import 'dart:html' hide History;

import 'package:wui_builder/components.dart';
import 'package:wui_builder/wui_builder.dart';
import 'package:wui_builder/vhtml.dart';

import '../core/nav.dart';
import '../../constants.dart';

import '../../model/user.dart';

import '../../state/app.dart';
import '../../middleware/serverMiddleware.dart';

class StoredDataProps {
  AppActions actions;
  User user;
}

class StoredData extends PComponent<StoredDataProps> {
  StoredData(props) : super(props);

  History _history;

  /// Browser history entrypoint, to control page navigation
  History get history => _history ?? findHistoryInContext(context);

  VNode emailInputNode;
  VNode passwordInputNode;

  @override
  VNode render() => new VDivElement()
    ..children = [
      new Nav(new NavProps()
        ..actions = props.actions
        ..user = props.user),
      new VDivElement()
        ..className = 'container'
        ..children = [
          new Vtable()
            ..className = 'table is-striped is-fullwidth'
            ..children = [
              new VTableRowElement()
                ..className = 'tr'
                ..children = [
                  new VTableCellElement()
                    ..className = 'title is-5'
                    ..text = "ID",
                  new VTableCellElement()
                    ..className = 'title is-5'
                    ..text = "Name",
                  new VTableCellElement()
                    ..className = 'title is-5'
                    ..text = "Number",
                ],
              new VTableRowElement()
                ..className = 'tr'
                ..children = [
                  new VTableCellElement()
                    ..className = 'td'
                    ..text = "1",
                  new VTableCellElement()
                    ..className = 'td'
                    ..text = "bob",
                  new VTableCellElement()
                    ..className = 'td'
                    ..text = "56",
                ],
              new VTableRowElement()
                ..className = 'tr'
                ..children = [
                  new VTableCellElement()
                    ..className = 'td'
                    ..text = "2",
                  new VTableCellElement()
                    ..className = 'td'
                    ..text = "fred",
                  new VTableCellElement()
                    ..className = 'td'
                    ..text = "780",
                ],
            ],
        ],
    ];
}