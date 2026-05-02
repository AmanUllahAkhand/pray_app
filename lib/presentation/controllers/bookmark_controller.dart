import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/models/quran/sura_details_model.dart';

class BookmarkController extends GetxController {

  final bookmarks = <AyahModel>[].obs;

  void addBookmark(AyahModel ayah) {

    if (!bookmarks.any((e) =>
    e.ayah == ayah.ayah &&
        e.suraName == ayah.suraName)) {

      bookmarks.add(ayah);
    }
  }

  void removeBookmark(AyahModel ayah) {

    bookmarks.removeWhere((e) =>
    e.ayah == ayah.ayah &&
        e.suraName == ayah.suraName);
  }

  bool isBookmarked(AyahModel ayah) {

    return bookmarks.any((e) =>
    e.ayah == ayah.ayah &&
        e.suraName == ayah.suraName);
  }
}