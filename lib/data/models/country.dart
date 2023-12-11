class Country {
  String name;
  String code;

  Country({required this.name, required this.code});

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        code = json['code'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}
