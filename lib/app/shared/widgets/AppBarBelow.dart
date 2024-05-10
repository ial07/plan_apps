import 'package:plan_apps/app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarBelow extends StatelessWidget {
  const AppBarBelow({
    Key? key,
    this.label,
    required this.rightWidget,
    required this.leftWidget,
  }) : super(key: key);

  final String? label;
  final Widget rightWidget;
  final Widget leftWidget;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: 10, horizontal: size.width * 0.07),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leftWidget,
              Text("$label",
                  style: GoogleFonts.inter(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              rightWidget,
            ],
          ),
        ),
        Container(
          height: 1,
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
                color: ColorConstants.black45,
                blurRadius: 1,
                offset: Offset(0, 3))
          ], color: Colors.transparent),
        ),
      ],
    );
  }
}
