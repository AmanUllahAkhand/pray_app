import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/constants/app_icons.dart';

class SupportController extends GetxController {
  final supportList = [
    {
      'title': 'Bkash Personal',
      'subtitle': '01783-901510',
      'icon': AppIcons.bkash,
    },
    {
      'title': 'Nagad',
      'subtitle': '01797-802655',
      'icon': AppIcons.nagad,
    },
    {
      'title': 'Wise',
      'subtitle': 'nurhassan902@gmail.com',
      'icon': AppIcons.wise,
    },
  ];

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar('Copied', text);
  }
}
