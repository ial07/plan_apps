import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_apps/app/shared/shared.dart';
import 'controller.dart';

class EditModalView extends GetView<EditModalController> {
  const EditModalView({Key? key}) : super(key: key);
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
              label: "DETAIL MODAL",
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
                        () => InputForm(
                          readOnly: !pageC.getMaster(),
                          label: "QTY",
                          Controller: controller.qty,
                          HintText: "masukan qty",
                          Preffix: Icon(Icons.calculate),
                          textError: controller.error.value["qty"],
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
                            ? Text("EDIT MODAL",
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
