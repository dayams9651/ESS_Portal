class EventModel {
  final int id;
  final String title;
  final String start;
  final String end;
  final String description;
  final String url;

  EventModel({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.description,
    required this.url,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      start: json['start'],
      end: json['end'],
      description: json['description'],
      url: json['url'],
    );
  }
}
