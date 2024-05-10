import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:plan_apps/app/shared/shared.dart';
import 'package:skeletons/skeletons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appBar extends StatelessWidget {
  const appBar({
    Key? key,
    required this.size,
    this.label,
    this.users,
    this.isSubdomain = false,
  }) : super(key: key);

  final Size size;
  final dynamic users;
  final String? label;
  final bool isSubdomain;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: label == null ? size.height * 0.2 : size.height * 0.1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ColorConstants.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(34), bottomRight: Radius.circular(34)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.04,
          right: size.width * 0.05,
          left: size.width * 0.05,
        ),
        child: Column(
          children: [
            label == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      users != null
                          ? Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: ColorConstants.white,
                                  child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: ColorConstants.white,
                                      backgroundImage: users?.photoURL != null
                                          ? NetworkImage(users!.photoURL!)
                                          : null),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Hallo,",
                                          style: GoogleFonts.inter(
                                              fontSize: 18,
                                              color: ColorConstants.white),
                                        ),
                                        Text(
                                          "${users!.displayName}",
                                          style: GoogleFonts.inter(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: ColorConstants.white),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Selamat datang kembali",
                                      style: GoogleFonts.inter(
                                          color: ColorConstants.white),
                                    )
                                  ],
                                ),
                              ],
                            )
                          : Row(children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    shape: BoxShape.circle,
                                    width: 50,
                                    height: 50),
                              ),
                              SizedBox(width: 8),
                              SkeletonParagraph(
                                style: SkeletonParagraphStyle(
                                    lines: 2,
                                    spacing: 6,
                                    lineStyle: SkeletonLineStyle(
                                      height: 10,
                                      alignment: Alignment.centerLeft,
                                      borderRadius: BorderRadius.circular(8),
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                    )),
                              ),
                            ]),
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Get.offAllNamed(Routes.LOGIN);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              Text(
                                "Logout",
                                style: GoogleFonts.poppins(
                                    fontSize: 8, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isSubdomain
                            ? InkWell(
                                onTap: () => Get.back(),
                                child: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : Container(),
                        Text(
                          label != null ? label! : "",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.white,
                              fontSize: 22),
                        ),
                        Container(),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
