import 'dart:convert';

CombinarModel combinarModelFromJson(String str) => CombinarModel.fromJson(json.decode(str));

String combinarModelToJson(CombinarModel data) => json.encode(data.toJson());

class CombinarModel {
  CombinarModel({
    this.id,
    required this.color,
    required this.forma,
  });

  String? id;
  String color;
  String forma;

  factory CombinarModel.fromJson(Map<String, dynamic> json) => CombinarModel(
        id: json["id"],
        color: json["color"],
        forma: json["forma"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
        "descripcion": forma,
      };
}
