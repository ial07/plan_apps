import 'package:get/get.dart';

import '../modules/home/home.dart';
import '../modules/list_plan/list_page.dart';
import '../modules/list_modal/list_modal.dart';
import '../modules/list_bon/list_bon.dart';
import '../modules/add_plan/add_plan.dart';
import '../modules/add_modal/add_modal.dart';
import '../modules/add_bon/add_bon.dart';
import '../modules/login/login.dart';
import '../modules/edit_task/edit_task.dart';
import '../modules/edit_plan/edit_plan.dart';
import '../modules/Edit_modal/edit_modal.dart';
import '../modules/Edit_bon/edit_bon.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.LISTPLAN,
      page: () => const ListPlanView(),
      binding: ListPlanBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.LISTMODAL,
      page: () => const ListModalView(),
      binding: ListModalBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.LISTBON,
      page: () => const ListBonView(),
      binding: ListBonBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.ADDPLAN,
      page: () => const AddPlanView(),
      binding: AddPlanBinding(),
    ),
    GetPage(
      name: _Paths.ADDMODAL,
      page: () => const AddModalView(),
      binding: AddModalBinding(),
    ),
    GetPage(
      name: _Paths.ADDBON,
      page: () => const AddBonView(),
      binding: AddBonBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.EDITTASK,
      page: () => const EditTaskView(),
      binding: EditTaskBinding(),
    ),
    GetPage(
      name: _Paths.EDITPLAN,
      page: () => const EditPlanView(),
      binding: EditPlanBinding(),
    ),
    GetPage(
      name: _Paths.EDITMODAL,
      page: () => const EditModalView(),
      binding: EditModalBinding(),
    ),
    GetPage(
      name: _Paths.EDITBON,
      page: () => const EditBonView(),
      binding: EditBonBinding(),
    ),
  ];
}
