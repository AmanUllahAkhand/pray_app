import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pray_app/core/constants/app_colors.dart';

class StyledSwitch extends StatelessWidget {
  final RxBool isToggled;
  final double size;
  final void Function(bool isToggled)? onToggled;

  const StyledSwitch({
    Key? key,
    required this.isToggled,
    this.onToggled,
    this.size = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double innerPadding = size / 10;

    return Obx(() {
      return GestureDetector(
        onTap: () {
          isToggled.value = !isToggled.value;
          if (onToggled != null) onToggled!(isToggled.value);
        },
        child: AnimatedContainer(
          height: size,
          width: size * 2,
          padding: EdgeInsets.all(innerPadding),
          alignment:
          isToggled.value ? Alignment.centerRight : Alignment.centerLeft,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isToggled.value ? primaryColor : backgroundColor,
            border: Border.all(color: Color(0xFFD9D9D9), width: 1),
          ),
          child: Container(
            width: size - innerPadding * 2,
            height: size - innerPadding * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color:
              isToggled.value ? backgroundColor : primaryColor,
            ),
          ),
        ),
      );
    });
  }
}
