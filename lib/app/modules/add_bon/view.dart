import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_apps/app/shared/shared.dart';
import 'controller.dart';

class AddBonView extends GetView<AddBonController> {
  const AddBonView({Key? key}) : super(key: key);
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
              label: "TAMBAH BON",
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
                          label: "KETERANGAN",
                          Controller: controller.keterangan,
                          HintText: "masukan keterangan",
                          Preffix: Icon(Icons.play_lesson),
                          textError: controller.error.value["keterangan"],
                        ),
                      ),
                      Obx(
                        () => DropdownForm(
                          itemDropdown: [
                            DropdownMenuItem(
                              child: Text(
                                'BELUM LUNAS',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'belum lunas',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'LUNAS',
                                style: GoogleFonts.poppins(),
                              ),
                              value: 'lunas',
                            ),
                          ],
                          label: "STATUS",
                          controller: controller,
                          textError: controller.error.value["opsi"],
                        ),
                      ),
                      Obx(
                        () => InputFormCurrancy(
                          label: "Harga",
                          Controller: controller.harga,
                          HintText: "masukan harga",
                          Preffix: Icon(Icons.calculate),
                          textError: controller.error.value["harga"],
                        ),
                      ),
                      Obx(
                        () => controller.image.value == null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tambah Foto (Optional)",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                                  ),
                                  InkWell(
                                    onTap: () => controller.imagePicker(),
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: ColorConstants.success,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorConstants.black,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(File(controller
                                                  .image.value!.path)),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 0,
                                        child: InkWell(
                                          onTap: () => controller.removeImage(),
                                          child: Container(
                                            padding: EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: ColorConstants.white),
                                            child: Padding(
                                              padding: const EdgeInsets.all(1),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color:
                                                        ColorConstants.Danger),
                                                child: Icon(
                                                  Icons.close,
                                                  color: ColorConstants.white,
                                                  size: 19,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
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
                        ? Text("TAMBAH BON",
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
