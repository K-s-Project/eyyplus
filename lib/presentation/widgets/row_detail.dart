import 'package:flutter/material.dart';

import 'customquicksandtext.dart';

class RowDetail extends StatelessWidget {
  final String text1;
  final String text2;
  final Color? color;
  final double size;
  const RowDetail({
    Key? key,
    required this.text1,
    required this.text2,
    this.color,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomQuickSandText(
          text: text1,
          weight: FontWeight.w700,
          size: 12,
          color: const Color(0xff000000).withOpacity(0.60),
          overflow: TextOverflow.ellipsis,
        ),
        CustomQuickSandText(
          text: text2,
          weight: FontWeight.w700,
          size: size,
          color: color ?? const Color(0xff000000).withOpacity(0.60),
        ),
      ],
    );
  }
}
