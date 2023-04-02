import 'dart:convert';

List<PublicEventModel> publicEventModelFromJson(String str) => List<PublicEventModel>.from(json.decode(str).map((x) => PublicEventModel.fromJson(x)));

String publicEventModelToJson(List<PublicEventModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PublicEventModel {
  PublicEventModel({
    required this.id,
    required this.name,
    required this.sender,
    required this.date,
    required this.description,
    required this.image,
    required this.startDate,
    required this.note,
  });

  String id;
  String name;
  String sender;
  String date;
  String description;
  String image;
  String startDate;
  String note;

  factory PublicEventModel.fromJson(Map<String, dynamic> json) => PublicEventModel(
    id: json["id"],
    name: json["name"],
    sender: json["sender"],
    date: json["date"],
    description: json["description"],
    image: json["image:"],
    startDate: json["startDate"],
    note: json["note"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sender": sender,
    "date": date,
    "description": description,
    "image:": image,
    "startDate": startDate,
    "note": note
  };
}