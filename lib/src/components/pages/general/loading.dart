import 'package:wui_builder/components.dart';
import 'package:wui_builder/wui_builder.dart';
import 'package:wui_builder/vhtml.dart';

import '../../../state/app.dart';

class LoadingProps {
  AppActions actions;
}

class Loading extends PComponent<LoadingProps> {
  Loading(props) : super(props);

  History _history;

  /// Browser history entrypoint, to control page navigation
  History get history => _history ?? findHistoryInContext(context);

  @override
  VNode render() => new VDivElement()
    ..className = 'container'
    ..children = [
      new VDivElement()
        ..className = 'columns is-centered margin-top'
        ..children = [
          new VDivElement()
            ..className = 'column is-narrow has-text-centered'
            ..children = [
              new VSpanElement()
                ..className = 'icon has-text-info'
                ..children = [
                  new Vi()..className = 'fas fa-sync fa-spin fa-4x',
                ]
            ],
        ],
      new VDivElement()
        ..className = 'columns is-centered'
        ..children = [
          new VDivElement()
            ..className = 'column is-narrow has-text-centered'
            ..children = [
              new VParagraphElement()
                ..className = 'subtitle'
                ..text = 'Loading...'
            ],
        ],
    ];
}
