import 'package:flutter/cupertino.dart';

class WidthAnimationBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  WidthAnimationBuilder(this.animation, this.child);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Container(
              width: animation.value,
              child: child,
            );
          },
          child: child),
    );
  }
}
