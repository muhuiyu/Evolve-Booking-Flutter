import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:flutter/material.dart';

enum CustomButtonType { primary, secondary, text }

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.type,
  });

  final Widget? child;
  final void Function() onPressed;
  final CustomButtonType type;

  Color _backgroundColor = ColorConstant.primary;
  Color _borderColor = ColorConstant.primary;
  double _borderWidth = 1;
  final double _borderRadius = 8;

  _configureStyle() {
    switch (type) {
      case CustomButtonType.primary:
        _backgroundColor = ColorConstant.primary;
        _borderColor = ColorConstant.primary;
        break;
      case CustomButtonType.secondary:
        _backgroundColor = Colors.transparent;
        _borderColor = ColorConstant.primary;
        break;
      case CustomButtonType.text:
        _backgroundColor = Colors.transparent;
        _borderColor = Colors.transparent;
        _borderWidth = 0;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _configureStyle();

    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ButtonStyle(
        padding:
            const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          side: BorderSide(width: _borderWidth, color: _borderColor),
        )),
        backgroundColor: MaterialStateProperty.all<Color>(_backgroundColor),
        elevation: const MaterialStatePropertyAll(0),
        shadowColor: const MaterialStatePropertyAll(Colors.transparent),
      ),
      child: child,
    );
  }
}

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.type,
  });

  final String text;
  final void Function() onPressed;
  final CustomButtonType type;

  Color _textColor = ColorConstant.white;

  _configureStyle() {
    switch (type) {
      case CustomButtonType.primary:
        _textColor = ColorConstant.white;
        break;
      case CustomButtonType.secondary:
        _textColor = ColorConstant.primary;
        break;
      case CustomButtonType.text:
        _textColor = ColorConstant.primary;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _configureStyle();

    return CustomButton(
        onPressed: onPressed,
        type: type,
        child: Text(text,
            style: TextStyleConstant.body(
                context, _textColor, TextStyleWeight.bold)));
  }
}
