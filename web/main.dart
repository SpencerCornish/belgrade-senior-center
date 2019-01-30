import 'dart:html' hide History;
import 'dart:async';
import 'package:sentry_client/sentry_client_browser.dart';
import 'package:sentry_client/sentry_dsn.dart';
import 'package:sentry_client/api_data/sentry_packet.dart';
import 'package:sentry_client/api_data/sentry_exception.dart';
import 'package:sentry_client/api_data/sentry_stacktrace.dart';
import 'package:sentry_client/api_data/sentry_stacktrace_frame.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:bsc/bsc.dart';
import 'package:wui_builder/wui_builder.dart';
import 'package:wui_builder/components.dart';

SentryClientBrowser sentryClient;
StoreContainer storeContainer;

void main() {
  runZoned(() {
    // Create a reporting client
    final dsn = SentryDsn.fromString('https://6b2404a092ac4502a821d9911d2a0e56@sentry.io/1311583');
    sentryClient = new SentryClientBrowser(dsn);

    storeContainer = new StoreContainer();
    render(new HistoryProvider(child: new Container(new ContainerProps()..storeContainer = storeContainer)),
        querySelector('.app-container'));
  }, onError: _handleZonedError, zoneSpecification: ZoneSpecification(handleUncaughtError: _handleUncaught));
}

_handleZonedError(var err, StackTrace stackTrace) {
  print("$err ${stackTrace.toString()}");
  _reportToSentry(err, stackTrace);
}

_handleUncaught(Zone zone, ZoneDelegate zoneDelegate, Zone zone2, var err, StackTrace stackTrace) {
  print("$err ${stackTrace.toString()}");
  _reportToSentry(err, stackTrace);
}

_reportToSentry(dynamic err, StackTrace stackTrace) async {
  if (document.domain.contains("localhost")) return;
  sentryClient.write(
    SentryPacket(
      extra: {
        "path": Uri?.base?.toString(),
        "userPlatform": window?.navigator?.platform,
        "UID": storeContainer?.store?.state?.user?.uid,
        "StateMap": storeContainer?.store?.state?.toString(),
      },
      exceptionValues: [
        SentryException(
          type: err?.runtimeType?.toString(),
          value: err?.toString(),
          stacktrace: _stackTraceToFrames(stackTrace),
        )
      ],
    ),
  );
}

SentryStacktrace _stackTraceToFrames(StackTrace stackTrace) {
  List<SentryStacktraceFrame> frames = <SentryStacktraceFrame>[];
  Chain stackChain = new Chain.forTrace(stackTrace);
  for (Trace trace in stackChain.traces) {
    for (Frame frame in trace.frames) {
      frames.add(SentryStacktraceFrame(
        absPath: frame.uri.toString(),
        function: frame.member,
        module: frame.library,
        lineno: frame.line,
        colno: frame.column,
        inApp: !frame.isCore,
      ));
    }
  }
  return new SentryStacktrace(frames: frames.reversed.toList());
}
