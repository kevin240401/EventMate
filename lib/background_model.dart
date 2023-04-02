// To parse this JSON data, do
//
//     final backgroundModel = backgroundModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<BackgroundModel> backgroundModelFromJson(String str) => List<BackgroundModel>.from(json.decode(str).map((x) => BackgroundModel.fromJson(x)));

String backgroundModelToJson(List<BackgroundModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BackgroundModel {
  BackgroundModel({

    required this.name,
    required this.image,
  });

  String name;
  String image;

  factory BackgroundModel.fromJson(Map<String, dynamic> json) => BackgroundModel(
    name: json["name"],
    image: json["image:"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image:": image,
  };

  factory BackgroundModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return BackgroundModel(
        name: data["name"],
        image: data["image"]
    );
  }
}
