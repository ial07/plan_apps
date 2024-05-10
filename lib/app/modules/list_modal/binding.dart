import 'package:get/get.dart';

import 'controller.dart';

class ListModalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListModalController>(
      () => ListModalController(),
    );
  }
}
