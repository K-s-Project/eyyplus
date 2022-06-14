import 'package:flutter/material.dart';

import 'customquicksandtext.dart';

class AddAppBar extends StatelessWidget {
  const AddAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xffBE5108),
            ),
          ),
          const SizedBox(
            width: 100,
          ),
          const CustomQuickSandText(
            text: 'Add Receipt',
            weight: FontWeight.w700,
            size: 18,
          ),
        ],
      ),
    );
  }
}
