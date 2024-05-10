import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plan_apps/app/shared/constants/colors.dart';
import 'package:intl/date_symbol_data_local.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    required this.size,
    required this.viewFunction,
    required this.date,
    required this.details,
    required this.color,
    this.by,
  }) : super(key: key);

  final Size size;
  final Function() viewFunction;
  final DateTime date;
  final String details;
  final String? by;
  final String color;

  @override
  Widget build(BuildContext context) {
    Color colors;
    if (color == "olah tanah") {
      colors = Colors.brown;
    } else if (color == "panen") {
      colors = Colors.yellow.shade700;
    } else if (color == "merumput") {
      colors = Colors.green.shade300;
    } else if (color == "meracun") {
      colors = Colors.grey.shade400;
    } else if (color == "menanam") {
      colors = Colors.lime.shade400;
    } else if (color == "mengairi") {
      colors = Colors.blue.shade300;
    } else {
      colors = Colors.blue.shade300;
    }

    initializeDateFormatting('id_ID');

    return Container(
      height: 100,
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                child: Container(
                  height: size.height,
                  width: 15,
                  color: colors,
                ),
              ),
              SizedBox(width: 5),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${DateFormat("EEEE ,dd-MM-yyyy", "id_ID").format(date)}",
                            style: GoogleFonts.poppins(),
                          ),
                          Text(
                            "by : ${by}",
                            style: GoogleFonts.poppins(
                                fontStyle: FontStyle.italic, fontSize: 12),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "${details}",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: viewFunction,
                child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: ColorConstants.gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(3)),
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
