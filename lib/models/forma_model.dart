// To parse this JSON data, do
//
//     final formaModel = formaModelFromJson(jsonString);

import 'dart:convert';

FormaModel formaModelFromJson(String str) => FormaModel.fromJson(json.decode(str));

String formaModelToJson(FormaModel data) => json.encode(data.toJson());

class FormaModel {
  FormaModel({
    this.id,
    required this.descripcion,
  });

  String? id;
  String descripcion;

  factory FormaModel.fromJson(Map<String, dynamic> json) => FormaModel(
        id: json["id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };
}
