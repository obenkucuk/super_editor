import 'package:flutter/widgets.dart';

class BlockingFocusNode extends FocusNode {
  BlockingFocusNode({this.readOnly = false});

  final bool readOnly;

  @override
  bool get hasFocus => readOnly ? false : super.hasFocus;

  @override
  void requestFocus([FocusNode? node]) {
    if (!readOnly) {
      super.requestFocus(node);
    }
  }

  @override
  void unfocus({
    UnfocusDisposition disposition = UnfocusDisposition.scope,
  }) {
    if (!readOnly) {
      super.unfocus(disposition: disposition);
    }
  }

  @override
  bool get hasPrimaryFocus => readOnly ? false : super.hasPrimaryFocus;

  @override
  bool get canRequestFocus => readOnly ? false : super.canRequestFocus;

  @override
  bool get descendantsAreFocusable => readOnly ? false : super.descendantsAreFocusable;

  @override
  bool focusInDirection(TraversalDirection direction) {
    if (!readOnly) {
      return FocusTraversalGroup.of(context!).inDirection(this, direction);
    }
    return false;
  }
}
