class CommuneModel {
  int? error;
  String? errorText;
  String? dataName;
  List<Data3>? data;

  CommuneModel({this.error, this.errorText, this.dataName, this.data});

  CommuneModel.fromJson(Map<String, dynamic> json) {
    error = json["error"];
    errorText = json["error_text"];
    dataName = json["data_name"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data3.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["error"] = error;
    _data["error_text"] = errorText;
    _data["data_name"] = dataName;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}



class Data3 {
  String? id;
  String? name;
  String? nameEn;
  String? fullName;
  String? fullNameEn;
  String? latitude;
  String? longitude;

  Data3(
      {this.id,
      this.name,
      this.nameEn,
      this.fullName,
      this.fullNameEn,
      this.latitude,
      this.longitude});

  Data3.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    nameEn = json["name_en"];
    fullName = json["full_name"];
    fullNameEn = json["full_name_en"];
    latitude = json["latitude"];
    longitude = json["longitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["name_en"] = nameEn;
    _data["full_name"] = fullName;
    _data["full_name_en"] = fullNameEn;
    _data["latitude"] = latitude;
    _data["longitude"] = longitude;
    return _data;
  }
}
