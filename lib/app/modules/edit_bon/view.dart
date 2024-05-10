import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_apps/app/shared/shared.dart';
import 'controller.dart';

class EditBonView extends GetView<EditBonController> {
  const EditBonView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pageC = Get.find<MainController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            appBar(
              size: size,
              label: "DETAIL BON",
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
                          readOnly: !pageC.getMaster(),
                          label: "KETERANGAN",
                          Controller: controller.keterangan,
                          HintText: "masukan keterangan",
                          Preffix: Icon(Icons.play_lesson),
                          textError: controller.error.value["keterangan"],
                        ),
                      ),
                      Obx(
                        () => DropdownForm(
                          enable: pageC.getMaster(),
                          value: controller.data["status"],
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
                          readOnly: !pageC.getMaster(),
                          label: "Harga",
                          Controller: controller.harga,
                          HintText: "masukan harga",
                          Preffix: Icon(Icons.calculate),
                          textError: controller.error.value["harga"],
                        ),
                      ),
                      pageC.getMaster()
                          ? Obx(() => controller.image.value == null
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
                                            onTap: () =>
                                                controller.removeImage(),
                                            child: Container(
                                              padding: EdgeInsets.zero,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: ColorConstants.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: ColorConstants
                                                          .Danger),
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
                                ))
                          : Container(),

                      ///foto
                      controller.data["photoUrl"] != null &&
                              controller.data["photoUrl"] != ""
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Foto Bukti",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (_) => ImageDialog(
                                        link: controller.data["photoUrl"]),
                                  ),
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                controller.data["photoUrl"]))),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  )),
            )),
            pageC.getMaster()
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.07, vertical: 15),
                    child: Obx(() => ButtonAction(
                        onTap: () async {
                          controller.isLoading.isFalse
                              ? await controller.processSubmit()
                              : null;
                        },
                        TextButton: controller.isLoading.isFalse
                            ? Text("EDIT BON",
                                style: GoogleFonts.poppins(
                                  color: ColorConstants.white,
                                  fontWeight: FontWeight.bold,
                                ))
                            : CircularProgressIndicator(
                                color: Colors.white,
                              ),
                        size: size)),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
