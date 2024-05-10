import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:plan_apps/app/shared/shared.dart';
import 'package:plan_apps/app/shared/widgets/ListCard.dart';
import 'controller.dart';

class ListPlanView extends GetView<ListPlanController> {
  const ListPlanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            appBar(
              size: size,
              label: "LIST PLAN",
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamPlan(),
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
                        itemCount: snapshot.data?.docs.length,
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
                                viewFunction: () => Get.toNamed(Routes.EDITPLAN,
                                    arguments: data),
                                date: DateTime.parse(data["planAt"]),
                                details: "${data["kegiatan"]}",
                                by: "${data["user"]}",
                                color: "${data["opsi"]}",
                              ));
                        },
                      );
                    } else {
                      return Center(child: Text("Error to Get Data"));
                    }
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: size.width * 0.07,
                  left: size.width * 0.07,
                  bottom: size.height * 0.01,
                  top: 15),
              child: ButtonAction(
                  onTap: () => Get.toNamed(Routes.ADDPLAN),
                  TextButton: Text("TAMBAH PLAN",
                      style: GoogleFonts.poppins(
                        color: ColorConstants.white,
                        fontWeight: FontWeight.bold,
                      )),
                  size: size),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(size: size),
    );
  }
}
