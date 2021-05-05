// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:math';

import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget _refresh({Key? key, Future<void> Function()? onRefresh}) =>
      onRefresh == null
          ? this
          : RefreshIndicator(
              key: key,
              onRefresh: onRefresh,
              child: this,
            );
}

class _appbarBottom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double titleHeight;
  _appbarBottom({
    Key? key,
    required this.titleHeight,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    return new Size.fromHeight(20.0);
  }
}

class RichAppBarPage extends StatefulWidget {
  final double titleHeight;
  final double titleHeightPos;
  final Widget? bottom;
  final Widget? body;
  final Widget? leading;
  final String title;
  final List<Widget>? actions;
  final Future<void> Function()? onRefresh;
  RichAppBarPage({
    Key? key,
    this.titleHeight = 40,
    this.titleHeightPos = 30,
    this.bottom,
    this.leading,
    this.title = "",
    this.body,
    this.onRefresh,
    this.actions,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _RichAppBarPageState();
  }
}

class _RichAppBarPageState extends State<RichAppBarPage> {
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();
  double _op = 0;
  late double _shouldHeight;
  @override
  void initState() {
    super.initState();
    _shouldHeight = widget.titleHeight;
    // WidgetBuilder(
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (widget.onRefresh != null) {
        _refreshKey.currentState?.show();
      }
      _scrollController
        ..addListener(() {
          setState(() {
            _shouldHeight = widget.titleHeight -
                max(
                    min(_scrollController.offset - widget.titleHeight,
                        widget.titleHeight),
                    0);
            // _op = (max(
            //         min(_scrollController.offset - widget.titleHeight,
            //             widget.titleHeightPos),
            //         0) /
            //     widget.titleHeightPos);
          });
        });
    });
  }

  @override
  void dispose() {
    // print("dispose");
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.leading,
        actions: widget.actions,
        title: Opacity(
          opacity: _op,
          child: Text(
            widget.title,
          ),
        ),
        elevation: 0,
        bottom: _appbarBottom(
          title: widget.title,
          titleHeight: _shouldHeight,
        ),
        backwardsCompatibility: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight +
                          widget.titleHeight +
                          widget.titleHeightPos,
                      maxHeight: double.infinity,
                    ),
                    child: widget.body != null ? widget.body! : Container(),
                  ),
                );
              },
            ),
          ),
          widget.bottom != null ? widget.bottom! : Container(),
        ],
      ),
    );
  }
}