import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class MyGesture extends StatefulWidget {
  const MyGesture({
    super.key,
    this.child,
    this.gestures = const <Type, GestureRecognizerFactory>{},
    this.behavior,
    this.excludeFromSemantics = false,
    this.semantics,
    this.gestureKey,
  });

  final Widget? child;
  final Map<Type, GestureRecognizerFactory<GestureRecognizer>> gestures;
  final HitTestBehavior? behavior;
  final bool excludeFromSemantics;
  final SemanticsGestureDelegate? semantics;
  final GlobalKey? gestureKey;

  @override
  State<MyGesture> createState() => _MyGestureState();
}

class _MyGestureState extends State<MyGesture> {
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      key: widget.gestureKey,
      gestures: widget.gestures,
      behavior: widget.behavior,
      excludeFromSemantics: widget.excludeFromSemantics,
      semantics: widget.semantics,
      child: widget.child,
    );
  }
}
