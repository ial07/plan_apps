import 'package:flutter/material.dart';
import 'package:plan_apps/app/shared/constants/colors.dart';

class ButtonAction extends StatelessWidget {
  ButtonAction({
    super.key,
    required this.onTap,
    required this.TextButton,
    required this.size,
    this.color,
    this.width,
  });

  final Function()? onTap;
  final Size size;
  final Widget TextButton;
  List<Color>? color;
  double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? size.width,
        height: 42,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: color ?? ColorConstants.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.black12,
              offset: Offset(5, 5),
              blurRadius: 5,
            )
          ],
        ),
        child: Center(
          child: TextButton,
        ),
      ),
    );
  }
}
