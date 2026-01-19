import 'package:get/get.dart';

import '../../core/constants/app_icons.dart';

class LanguageController extends GetxController {
  final selectedLanguage = 'en'.obs;

  final languages = [
    {
      'code': 'en',
      'title': 'English',
      'flag': AppIcons.engLan,
    },
    {
      'code': 'bn',
      'title': 'Bangla',
      'flag': AppIcons.banLan,
    },
  ];

  void changeLanguage(String code) {
    selectedLanguage.value = code;
  }
}
