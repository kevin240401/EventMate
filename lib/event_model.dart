class Data {
  final String description;
  final String image;
  final String locationName;
  final String performerName;
  final String startDate;
  final String endDate;

  const Data({
    this.description = '',
    this.image = '',
    this.locationName = '',
    this.performerName = '',
    this.startDate = '',
    this.endDate = '',
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final event = json;
    return Data(
      description: event['description'] as String? ?? '',
      image: event['image'] as String? ?? '',
      locationName: event['location']['name'] as String? ?? '',
      performerName: event['performer'][0]['name'] as String? ?? '',
      startDate: event['startDate'] as String? ?? '',
      endDate: event['endDate'] as String? ?? '',
    );
  }
}



class MyData {
  final List<Data> data;

  MyData({required this.data});

  factory MyData.fromJson(Map<String, dynamic> json) {
    List<Data> data = [];
    for (var item in json['data']) {
      data.add(Data.fromJson(item));
    }
    return MyData(data: data);
  }

}