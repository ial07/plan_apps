import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_apps/app/shared/shared.dart';
import 'package:plan_apps/app/shared/widgets/DropdownForm.dart';
import 'controller.dart';

class AddTaskView extends GetView<AddTaskController> {
  const AddTaskView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Get.put(AddTaskController());
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.07, vertical: 15),
      child: SingleChildScrollView(
          child: Form(
        key: controller.formTask,
        child: Column(
          children: [
            Text(
              "TAMBAH KEGIATAN",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Container(
              height: 1,
              color: Colors.black87,
              width: size.width,
            ),
            SizedBox(height: 25),
            Obx(
              () => InputForm(
                HintText: "Tambah Kegiatan",
                Controller: controller.kegiatan,
                Preffix: Icon(Icons.edit_note_outlined),
                label: "Kegiatan",
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
              () => controller.dropdownValue.value == "panen"
                  ? InputForm(
                      HintText: "Banyak panen",
                      Controller: controller.qty,
                      Preffix: Icon(Icons.calculate),
                      label: "Banyak panen",
                      textError: controller.error.value["qty"],
                    )
                  : Container(),
            ),
            SizedBox(height: 20),
            Obx(
              () => controller.image.value == null
                  ? controller.dropdownValue.value == "panen" ||
                          controller.dropdownValue.value == "menanam"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      : Container()
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
                                    image: FileImage(
                                        File(controller.image.value!.path)),
                                  ),
                                  borderRadius: BorderRadius.circular(6)),
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
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorConstants.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: ColorConstants.Danger),
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
            SizedBox(height: 20),
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.07, vertical: 5),
                child: ButtonAction(
                    onTap: () async {
                      controller.isLoading.isFalse
                          ? await controller.processSubmit()
                          : null;
                    },
                    TextButton: controller.isLoading.isFalse
                        ? Text("TAMBAH KEGIATAN",
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
      )),
    );
  }
}
