import '../../data/models/quran/sura_details_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class BookmarkController extends GetxController {

  final bookmarks = <AyahModel>[].obs;

  late Box bookmarkBox;

  @override
  void onInit() {
    super.onInit();

    bookmarkBox = Hive.box('bookmarkBox');

    loadBookmarks();
  }

  /// ================= LOAD =================
  void loadBookmarks() {

    final data = bookmarkBox.values.toList();

    bookmarks.assignAll(
      data.map((e) => AyahModel.fromMap(Map<String, dynamic>.from(e))).toList(),
    );
  }

  /// ================= ADD =================
  void addBookmark(AyahModel ayah) {

    final alreadyExist = bookmarks.any(
          (e) =>
      e.ayah == ayah.ayah &&
          e.suraName == ayah.suraName,
    );

    if (alreadyExist) return;

    bookmarks.add(ayah);

    bookmarkBox.add(ayah.toMap());
  }

  /// ================= REMOVE =================
  void removeBookmark(AyahModel ayah) {

    final index = bookmarks.indexWhere(
          (e) =>
      e.ayah == ayah.ayah &&
          e.suraName == ayah.suraName,
    );

    if (index == -1) return;

    bookmarks.removeAt(index);

    bookmarkBox.deleteAt(index);
  }

  /// ================= CHECK =================
  bool isBookmarked(AyahModel ayah) {

    return bookmarks.any(
          (e) =>
      e.ayah == ayah.ayah &&
          e.suraName == ayah.suraName,
    );
  }
}