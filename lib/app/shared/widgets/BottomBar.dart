import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final pageC = Get.find<MainController>();
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      cornerRadius: 10,
      backgroundColor: ColorConstants.success,
      items: [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.list_alt, title: 'List Plan'),
        TabItem(icon: Icons.add, title: 'Tambah Kegiatan'),
        TabItem(icon: Icons.list_alt, title: 'List Modal'),
        TabItem(icon: Icons.list_alt, title: 'List Bon'),
      ],
      initialActiveIndex: pageC.pageIndex.value, //optional, default as 0
      onTap: (int i) => pageC.changePage(i),
    );
  }
}
