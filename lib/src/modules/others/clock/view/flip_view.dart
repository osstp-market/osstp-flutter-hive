import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../../common/utils/screen_utils.dart';

class FlipNumText extends StatefulWidget {
  final int num;
  final int maxNum;
  // Default + 1
  final int calNum;

  final Size? size;
  const FlipNumText(this.num, this.maxNum, {super.key, this.calNum = 1, this.size});

  @override
  _FlipNumTextState createState() => _FlipNumTextState();
}

class _FlipNumTextState extends State<FlipNumText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  bool _isReversePhase = false;

  final double _zeroAngle = 0.0001;

  int _stateNum = 0;

  @override
  void initState() {
    super.initState();

    _stateNum = widget.num;

    ///动画控制器，正向执行一次后再反向执行一次每次时间为450ms。
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ///正向动画执行结束后，反向动画执行标志位设置true 进行反向动画执行
          _controller.reverse();
          _isReversePhase = true;
//          print("AnimationStatus.completed");
        }
        if (status == AnimationStatus.dismissed) {
          ///反向动画执行结束后，反向动画执行标志位false 将当前数值加一更改为动画后的值
          _isReversePhase = false;
          _calNum();
//          print("AnimationStatus.dismissed");
        }
      })
      ..addListener(() {
        setState(() {});
      });

    ///四分之一的圆弧长度
    _animation = Tween(begin: _zeroAngle, end: pi / 2).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: <Widget>[
              ClipRectText(_nextNum(), Alignment.topCenter, color, widget.size),

              ///动画正向执行翻转的组件
              Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.006)
                    ..rotateX(_isReversePhase ? pi / 2 : _animation.value),
                  alignment: Alignment.bottomCenter,
                  child: ClipRectText(_stateNum, Alignment.topCenter, color, widget.size)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
          ),
          Stack(
            children: <Widget>[
              ClipRectText(_stateNum, Alignment.bottomCenter, color, widget.size),

              ///动画反向执行翻转的组件
              Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.006)
                    ..rotateX(_isReversePhase ? -_animation.value : pi / 2),
                  alignment: Alignment.topCenter,
                  child: ClipRectText(_nextNum(), Alignment.bottomCenter, color, widget.size)),
            ],
          )
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(FlipNumText oldWidget) {
    if (widget.num != oldWidget.num) {
      _controller.forward();
      if (widget.calNum != 0) {
        // 通过计数方法【_nextNum()】和【_calNum()】累计
        _stateNum = oldWidget.num;
      } else {
        // 通过每次刷新UI的【widget.num】累计
        _stateNum = widget.num;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  _nextNum() {
    if (_stateNum == widget.maxNum) {
      return 0;
    } else {
      return _stateNum + widget.calNum;
    }
  }

  _calNum() {
    if (_stateNum == widget.maxNum) {
      _stateNum = 0;
    } else {
      // 动画后 + calNum
      _stateNum += widget.calNum;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class ClipRectText extends StatelessWidget {
  final int _value;
  final Alignment _alignment;
  final Color _color;
  final Size? _size;

  const ClipRectText(this._value, this._alignment, this._color, this._size, {super.key});

  @override
  Widget build(BuildContext context) {
    double maxWidth = screenWidth / 5 + 10;
    return ClipRect(
      child: Align(
        alignment: _alignment,
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.all( 10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Flexible(
            child: Text(
              fixed(_value),
              style: TextStyle(
                // fontSize: (_size?.width ?? maxWidth) - 30,
                color: _color,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }

  fixed(n) {
    String s = n.toString();
    if (n < 10) {
      s = '0$s';
    }
    return s;
  }
}
