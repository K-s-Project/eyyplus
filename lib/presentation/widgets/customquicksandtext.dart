import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomQuickSandText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final TextOverflow? overflow;
  final TextAlign? align;
  const CustomQuickSandText({
    Key? key,
    required this.text,
    this.size,
    this.weight,
    this.color,
    this.overflow,
    this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.quicksand(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
      overflow: overflow,
      textAlign: align,
    );
  }
}
