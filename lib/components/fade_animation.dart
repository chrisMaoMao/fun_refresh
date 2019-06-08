import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  const FadeAnimation(
      {this.child, this.duration = const Duration(milliseconds: 666)});

  final child;
  final duration;

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  initState() {
    super.initState();
    animationController =
        AnimationController(duration: widget.duration, vsync: this);
    animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    animationController.forward(from: 0.0);
  }

  @override
  deactivate() {
    animationController.stop();
    super.deactivate();
  }

  @override
  didUpdateWidget(FadeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      animationController.forward(from: 0.0);
    }
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  build(context) => animationController.isAnimating
      ? Opacity(
          opacity: 1.0 - animationController.value,
          child: widget.child,
        )
      : Container();
}
