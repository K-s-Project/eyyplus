import 'package:flutter/material.dart';
import 'package:general/general.dart';

class Searchbar extends StatelessWidget {
  final TextEditingController controller;
  const Searchbar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      width: 270,
      child: CustomTextField(
        'search something...',
        controller: controller,
        radius: 15,
        color: const Color(0xff58739B).withOpacity(0.40),
      ),
    );
  }
}
