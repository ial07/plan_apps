import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_apps/app/shared/shared.dart';

class InputForm extends StatelessWidget {
  final Widget Preffix;
  final Widget? Suffix;
  final String HintText;
  final TextEditingController Controller;
  final String? Function(String?)? ControllerValidator;
  final String? textError;
  final TextInputType? textInput;
  final bool? readOnly;
  final bool? obscureText;
  final String label;
  final Function()? onTap;

  const InputForm({
    super.key,
    required this.HintText,
    required this.Controller,
    required this.Preffix,
    this.Suffix,
    this.ControllerValidator,
    this.textError,
    this.textInput,
    this.readOnly = false,
    this.obscureText = false,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 10),
        TextFormField(
          maxLines: null,
          onTap: onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: Controller,
          autocorrect: false,
          obscureText: obscureText!,
          readOnly: readOnly!,
          validator: ControllerValidator,
          keyboardType: textInput,
          style: GoogleFonts.poppins(
              color:
                  readOnly! ? ColorConstants.black45 : ColorConstants.black87),
          decoration: InputDecoration(
            prefixIcon: IconButton(onPressed: null, icon: Preffix),
            suffixIcon: Suffix,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: textError != null
                      ? ColorConstants.Danger
                      : ColorConstants.lightGray),
              borderRadius: BorderRadius.circular(9),
            ),
            errorStyle: TextStyle(color: ColorConstants.Warning),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              borderSide: BorderSide(color: ColorConstants.Warning, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              borderSide: BorderSide(color: ColorConstants.Warning, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.lightGray),
              borderRadius: BorderRadius.circular(9),
            ),
            hintText: "$HintText",
            filled: true,
            fillColor: readOnly! ? ColorConstants.brightGray : Colors.white,
          ),
        ),
        textError != null
            ? Row(
                children: [
                  SizedBox(height: 20, width: size.width * 0.1),
                  Icon(Icons.warning, color: ColorConstants.Danger, size: 18),
                  SizedBox(width: 5),
                  Container(
                    width: size.width * 0.67,
                    child: Text(
                      "$textError",
                      style: GoogleFonts.inter(color: ColorConstants.Danger),
                    ),
                  ),
                ],
              )
            : Container(),
        SizedBox(height: 16),
      ],
    );
  }
}
