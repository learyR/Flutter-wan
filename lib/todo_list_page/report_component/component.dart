import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class ReportComponent extends Component<ReportState> {
  ReportComponent()
      : super(
          view: buildView,
        );
}
