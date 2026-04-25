class SuraModel {
  final int id;
  final String nameEn;
  final String nameAr;
  final int verses;
  final String type;

  SuraModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.verses,
    required this.type,
  });

  factory SuraModel.fromJson(Map<String, dynamic> json) {
    return SuraModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      verses: json['verses'],
      type: json['type'],
    );
  }
}