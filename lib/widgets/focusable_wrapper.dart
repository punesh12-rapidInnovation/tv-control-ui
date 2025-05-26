import 'package:flutter/material.dart';

class FocusableWrapper extends StatefulWidget {
  final Widget child;
  final FocusNode? focusNode;
  final VoidCallback? onFocusChange;
  final double borderWidth;
  final Color focusedBorderColor;
  final Color unfocusedBorderColor;
  final BorderRadius borderRadius;
  final bool autofocus;

  const FocusableWrapper({
    super.key,
    required this.child,
    this.focusNode,
    this.onFocusChange,
    this.borderWidth = 2.0,
    this.focusedBorderColor = Colors.white,
    this.unfocusedBorderColor = Colors.transparent,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.autofocus = false,
  });

  @override
  State<FocusableWrapper> createState() => _FocusableWrapperState();
}

class _FocusableWrapperState extends State<FocusableWrapper> {
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.autofocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onFocusChange: (hasFocus) {
        setState(() {
          _hasFocus = hasFocus;
        });
        widget.onFocusChange?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _hasFocus ? widget.focusedBorderColor : widget.unfocusedBorderColor,
            width: widget.borderWidth,
          ),
          borderRadius: widget.borderRadius,
        ),
        child: widget.child,
      ),
    );
  }
} 