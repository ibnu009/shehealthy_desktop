import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

const Curve _curve = Curves.ease;
const Duration _duration = Duration(milliseconds: 300);

class HoverButton extends StatefulWidget {
  const HoverButton({
    Key? key,
    required this.color,
    this.icon,
    required this.text,
  }) : super(key: key);

  final Color color;
  final Widget? icon;
  final String text;

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTapDown: (_) => setState(() => hover = true),
    onTapUp: (_) => setState(() => hover = false),
    onTapCancel: () => setState(() => hover = false),
    child: MouseRegion(
      onHover: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: Container(
        width: 78,
        height: 96,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 4),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  curve: _curve,
                  duration: _duration,
                  bottom: hover ? -20 : -14,
                  child: AnimatedOpacity(
                    curve: _curve,
                    duration: _duration,
                    opacity: hover ? 1 : 0,
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: widget.color,
                      ),
                    ),
                  ),
                ),
                _HoverBorderContainer(
                  color: widget.color,
                  icon: widget.icon,
                  hover: hover,
                  offset: Offset(0, -0.5),
                ),
                ...List.generate(4, (index) {
                  return _HoverBorderContainer(
                    color: widget.color,
                    hover: hover,
                    offset: Offset(0, -(index + 1) * 0.1),
                    opacity: (index + 1) * 0.2,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _HoverBorderContainer extends ImplicitlyAnimatedWidget {
  const _HoverBorderContainer({
    Key? key,
    required this.color,
    this.icon,
    required this.offset,
    this.opacity,
    this.hover = false,
    Duration duration = _duration,
    Curve curve = _curve,
  }) : super(
    key: key,
    duration: duration,
    curve: curve,
  );

  final Color color;
  final Widget? icon;
  final bool hover;
  final Offset offset;
  final double? opacity;

  @override
  __HoverBorderContainerState createState() => __HoverBorderContainerState();
}

class __HoverBorderContainerState
    extends AnimatedWidgetBaseState<_HoverBorderContainer> {
  Tween<double>? _doubleTween;
  @override
  Widget build(BuildContext context) {
    double value = _doubleTween?.evaluate(animation) ?? 0.0;
    return FractionalTranslation(
      translation: Offset.lerp(Offset.zero, widget.offset, value)!,
      child: Transform.rotate(
        alignment: Alignment.center,
        angle: lerpDouble(0, -35 * pi / 180, value)!,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.skewX(lerpDouble(0, 20 * pi / 180, value)!),
          child: Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.color,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size.square(26)),
              child: widget.icon,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _doubleTween = visitor(_doubleTween, widget.hover ? 1.0 : 0.0,
            (value) => Tween<double>(begin: value as double)) as Tween<double>;
  }
}