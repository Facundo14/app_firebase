// To parse this JSON data, do
//
//     final colorModel = colorModelFromJson(jsonString);

import 'dart:convert';

ColorModel colorModelFromJson(String str) => ColorModel.fromJson(json.decode(str));

String colorModelToJson(ColorModel data) => json.encode(data.toJson());

class ColorModel {
  ColorModel({
    this.id,
    required this.color,
    required this.descripcion,
  });

  String? id;
  String color;
  String descripcion;

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        id: json["id"],
        color: json["color"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
        "descripcion": descripcion,
      };
}
