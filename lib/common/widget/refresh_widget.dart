import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../generated/l10n.dart';

class RefreshWidget extends StatefulWidget {
  const RefreshWidget({Key? key, required this.refreshController, required this.child, this.onRefresh, this.onLoading})
      : super(key: key);
  final RefreshController refreshController;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final Widget child;
  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  late RefreshController _refreshController;

  void _onRefresh() async {
    if (widget.onRefresh != null) {
      widget.onRefresh!();
    } else {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 2000));
      // if failed,use refreshFailed()
      widget.refreshController.refreshCompleted();
    }
  }

  void _onLoading() async {
    if (widget.onLoading != null) {
      widget.onLoading!();
    } else {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()
      widget.refreshController.loadComplete();
    }
  }

  @override
  initState() {
    super.initState();
    _refreshController = widget.refreshController;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text(S.of(context).general_pull_up_load);
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text(S.of(context).general_Load_Failed_Click_retry);
          } else if (mode == LoadStatus.canLoading) {
            body = Text(S.of(context).general_load_more);
          } else {
            body = Text(S.of(context).general_no_more_data);
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enableTwoLevel: true,
      child: widget.child,
    );
  }
}

class TwoLevelWidget {}
