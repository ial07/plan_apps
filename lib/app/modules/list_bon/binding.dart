import 'package:get/get.dart';

import 'controller.dart';

class ListBonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListBonController>(
      () => ListBonController(),
    );
  }
}
