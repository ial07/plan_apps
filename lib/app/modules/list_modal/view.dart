import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plan_apps/app/routes/app_pages.dart';
import 'package:plan_apps/app/shared/shared.dart';
import 'controller.dart';

class ListModalView extends GetView<ListModalController> {
  const ListModalView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final f = NumberFormat();
    final pageC = Get.find<MainController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            appBar(
              size: size,
              label: "LIST MODAL",
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamModal(),
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
                            child: Text("Anda Tidak Memiliki List Modal"),
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Table(
                                border: TableBorder(
                                    left: BorderSide(
                                        width: 1, color: Colors.black54),
                                    right: BorderSide(
                                        width: 1, color: Colors.black54),
                                    top: BorderSide(
                                        width: 1, color: Colors.black54),
                                    verticalInside: BorderSide(
                                        width: 1, color: Colors.black54)),
                                columnWidths: <int, TableColumnWidth>{
                                  0: FixedColumnWidth(40),
                                  1: FlexColumnWidth(),
                                  2: FixedColumnWidth(40),
                                  3: FixedColumnWidth(90),
                                  4: FixedColumnWidth(40),
                                },
                                children: [
                                  TableRow(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text(
                                            "NO",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text(
                                            "KETERANGAN",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text(
                                            "QTY",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text(
                                            "HARGA (RP)",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text(
                                            "ACT",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ])
                                ],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data =
                                    snapshot.data!.docs[index].data();
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Table(
                                    border: TableBorder.all(
                                        width: 1, color: Colors.black54),
                                    columnWidths: <int, TableColumnWidth>{
                                      0: FixedColumnWidth(40),
                                      1: FlexColumnWidth(),
                                      2: FixedColumnWidth(40),
                                      3: FixedColumnWidth(90),
                                      4: FixedColumnWidth(40),
                                    },
                                    children: [
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              (index + 1).toString(),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              "${data["keterangan"]}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              "${data["qty"]}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              "${f.format(data["amount"])}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: InkWell(
                                                onTap: () => Get.toNamed(
                                                    Routes.EDITMODAL,
                                                    arguments: data),
                                                child: Icon(
                                                  Icons.remove_red_eye,
                                                  size: 20,
                                                  color: ColorConstants.success,
                                                ),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TOTAL",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Obx(
                          () => Text(
                            "RP. ${f.format(controller.total.value)}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pageC.getMaster()
                      ? ButtonAction(
                          onTap: () => Get.toNamed(Routes.ADDMODAL),
                          TextButton: Text("TAMBAH MODAL",
                              style: GoogleFonts.poppins(
                                color: ColorConstants.white,
                                fontWeight: FontWeight.bold,
                              )),
                          size: size)
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(size: size),
    );
  }
}
