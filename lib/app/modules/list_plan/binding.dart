import 'package:get/get.dart';

import 'controller.dart';

class ListPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPlanController>(
      () => ListPlanController(),
    );
  }
}
