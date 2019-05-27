import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';
import 'view.dart';

class ReportComponent extends Component<ReportState>
    with PrivateReducerMixin<ReportState> {
  UniqueKey uniqueKey = UniqueKey();

  ReportComponent()
      : super(
          view: buildView,
        );
}
