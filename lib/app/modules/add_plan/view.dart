import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_apps/app/shared/shared.dart';
import 'controller.dart';

class AddPlanView extends GetView<AddPlanController> {
  const AddPlanView({Key? key}) : super(key: key);
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
              label: "TAMBAH PLAN",
              isSubdomain: true,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.07, vertical: 15),
                  child: Column(
                    children: [
                      Obx(
                        () => InputForm(
                          label: "Rencana Kegiatan",
                          Controller: controller.kegiatan,
                          HintText: "masukan rencana",
                          Preffix: Icon(Icons.play_lesson),
                          textError: controller.error.value["kegiatan"],
                        ),
                      ),
                      Obx(
                        () => DropdownForm(
                          itemDropdown: [
                            DropdownMenuItem(
                              child: Text(
                                'Olah Tanah',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'olah tanah',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Menanam',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'menanam',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Meracun',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'meracun',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Merumput',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'merumput',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Mengairi / Menyiram',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'mengairi',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Panen',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'panen',
                            ),
                          ],
                          label: "Jenis Kegiatan",
                          controller: controller,
                          textError: controller.error.value["opsi"],
                        ),
                      ),
                      Obx(
                        () => InputForm(
                          label: "Tanggal",
                          Controller: controller.date,
                          HintText: "masukan tanggal",
                          textError: controller.error.value["tanggal"],
                          Preffix: Icon(Icons.date_range),
                          onTap: () {
                            controller.choseeDate();
                          },
                        ),
                      ),
                    ],
                  )),
            )),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07, vertical: 15),
                child: ButtonAction(
                    onTap: () async {
                      controller.isLoading.isFalse
                          ? await controller.processSubmit()
                          : null;
                    },
                    TextButton: controller.isLoading.isFalse
                        ? Text("TAMBAH PLAN",
                            style: GoogleFonts.poppins(
                              color: ColorConstants.white,
                              fontWeight: FontWeight.bold,
                            ))
                        : CircularProgressIndicator(
                            color: Colors.white,
                          ),
                    size: size),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
