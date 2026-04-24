class LocationInfoModel {
  final String city;
  final String country;
  final String hijriDate;
  final String gregorianDate;

  LocationInfoModel({
    required this.city,
    required this.country,
    required this.hijriDate,
    required this.gregorianDate,
  });

  factory LocationInfoModel.fromJson(Map<String, dynamic> json) {
    return LocationInfoModel(
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      hijriDate: json['hijri_date'] ?? '',
      gregorianDate: json['gregorian_date'] ?? '',
    );
  }
}