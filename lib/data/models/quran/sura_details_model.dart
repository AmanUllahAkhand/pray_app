class AyahModel {
  final int ayah;
  final String arabic;
  final String transliteration;
  final String bangla;
  final String suraName;

  AyahModel({
    required this.ayah,
    required this.arabic,
    required this.transliteration,
    required this.bangla,
    required this.suraName,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      ayah: json['ayah'],
      arabic: json['arabic'],
      transliteration: json['transliteration'],
      bangla: json['bangla'],
      suraName: json['sura_name'] ?? '',
    );
  }
}