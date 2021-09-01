import 'dart:convert';

CombinarModel combinarModelFromJson(String str) => CombinarModel.fromJson(json.decode(str));

String combinarModelToJson(CombinarModel data) => json.encode(data.toJson());

class CombinarModel {
  CombinarModel({
    this.id,
    required this.color,
    required this.colorNombre,
    required this.forma,
    this.descripcion,
    this.idFirebase,
  });

  int? id;
  String color;
  String colorNombre;
  String forma;
  String? descripcion;
  String? idFirebase;

  factory CombinarModel.fromJson(Map<String, dynamic> json) => CombinarModel(
        id: json["id"],
        color: json["color"] ?? '',
        colorNombre: json["colorNombre"] ?? '',
        forma: json["forma"] ?? '',
        descripcion: json["descripcion"],
        idFirebase: json["idFirebase"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
        "colorNombre": colorNombre,
        "forma": forma,
        "descripcion": descripcion,
        "idFirebase": idFirebase,
      };
}
