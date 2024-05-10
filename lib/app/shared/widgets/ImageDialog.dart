import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageDialog extends StatelessWidget {
  final String link;
  const ImageDialog({
    super.key,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Image.network(link, width: 1000, height: 1000, fit: BoxFit.cover),
    );
  }
}
