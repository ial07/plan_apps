import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_apps/app/shared/constants/colors.dart';

class DropdownForm extends StatelessWidget {
  const DropdownForm({
    Key? key,
    required this.controller,
    required this.label,
    this.value,
    this.textError,
    this.enable = true,
    required this.itemDropdown,
  }) : super(key: key);

  final dynamic controller;
  final String label;
  final String? value;
  final String? textError;
  final bool? enable;
  final List<DropdownMenuItem<String>> itemDropdown;

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
        FormBuilder(
          child: FormBuilderDropdown(
            enabled: enable!,
            name: 'dropdown_field',
            initialValue: value,
            decoration: InputDecoration(labelText: 'Pilih opsi'),
            onChanged: (newValue) {
              controller.dropdownValue.value = newValue!;
            },
            items: itemDropdown,
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
        SizedBox(height: 15),
      ],
    );
  }
}
