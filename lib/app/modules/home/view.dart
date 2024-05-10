import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:plan_apps/app/shared/shared.dart';
import 'controller.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var date = DateTime.now();

    initializeDateFormatting('id_ID');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: size.height * 0.3,
                child: Stack(
                  children: [
                    appBar(
                      size: size,
                      users: controller.auth.currentUser,
                    ),

                    /// Card Weather
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: size.width,
                            height: size.height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: size.width * 0.83,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Plan Hari Ini",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                              Container(
                                                width: 110,
                                                child: Text(
                                                  "${DateFormat("EEEE ,dd-MM-yyyy", "id_ID").format(date)}",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        StreamBuilder<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>(
                                            stream:
                                                controller.streamPlanToday(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: Colors.white,
                                                ));
                                              }
                                              if (snapshot.hasData) {
                                                if (snapshot.data?.docs
                                                            .length ==
                                                        0 ||
                                                    snapshot.data == null) {
                                                  return Container(
                                                    width: size.width * 0.8,
                                                    child: Center(
                                                      child: Text(
                                                        "Anda Tidak Memiliki Plan Hari Ini",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    ColorConstants
                                                                        .grey),
                                                      ),
                                                    ),
                                                  );
                                                }

                                                Map<String, dynamic> data =
                                                    snapshot.data!.docs[0]
                                                        .data();
                                                Color colors;
                                                if (data["opsi"] ==
                                                    "olah tanah") {
                                                  colors = Colors.brown;
                                                } else if (data["opsi"] ==
                                                    "panen") {
                                                  colors =
                                                      Colors.yellow.shade700;
                                                } else if (data["opsi"] ==
                                                    "merumput") {
                                                  colors =
                                                      Colors.green.shade300;
                                                } else if (data["opsi"] ==
                                                    "meracun") {
                                                  colors = Colors.grey.shade400;
                                                } else if (data["opsi"] ==
                                                    "menanam") {
                                                  colors = Colors.lime.shade400;
                                                } else if (data["opsi"] ==
                                                    "mengairi") {
                                                  colors = Colors.blue.shade300;
                                                } else {
                                                  colors = Colors.blue.shade300;
                                                }

                                                return Container(
                                                  width: size.width * 0.8,
                                                  child: Text(
                                                    "${data["kegiatan"]}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: colors),
                                                  ),
                                                );
                                              } else {
                                                return Center(
                                                    child: Text(
                                                        "Error to Get Data"));
                                              }
                                            }),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 25),

              /// daftar manifest container
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Container(
                  height: 42,
                  width: size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: ColorConstants.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 55,
                        width: 25,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                          color: Color(0xf9f9f9f9),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                        )),
                      ),
                      Text(
                        "LIST KEGIATAN",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 55,
                        width: 25,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                          color: Color(0xf9f9f9f9),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50)),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamTask(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data?.docs.length == 0 ||
                          snapshot.data == null) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Text("Anda Tidak Memiliki Kegiatan"),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              snapshot.data!.docs[index].data();
                          return Padding(
                            padding: EdgeInsets.only(
                                right: size.width * 0.07,
                                left: size.width * 0.07,
                                bottom: size.height * 0.01,
                                top: 15),
                            child: ListCard(
                              size: size,
                              viewFunction: () =>
                                  Get.toNamed(Routes.EDITTASK, arguments: data),
                              date: DateTime.parse(data["createdAt"]),
                              details: "${data["kegiatan"]}",
                              by: "${data["user"]}",
                              color: "${data["opsi"]}",
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text("Error to Get Data"));
                    }
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(size: size),
    );
  }
}
