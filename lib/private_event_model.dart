import 'dart:convert';

List<PrivateEventModel> privateEventModelFromJson(String str) => List<PrivateEventModel>.from(json.decode(str).map((x) => PrivateEventModel.fromJson(x)));

String privateEventModelToJson(List<PrivateEventModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrivateEventModel {
  PrivateEventModel({
    required this.id,
    required this.name,
    required this.sender,
    required this.date,
    required this.description,
    required this.image,
    required this.note,
  });

  String id;
  String name;
  String sender;
  String date;
  String description;
  String image;
  String note;

  factory PrivateEventModel.fromJson(Map<String, dynamic> json) => PrivateEventModel(
    id: json["id"],
    name: json["name"],
    sender: json["sender"],
    date: json["date"],
    description: json["description"],
    image: json["image:"],
    note: json["note"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sender": sender,
    "date": date,
    "description": description,
    "image:": image,
    "note":note
  };
}