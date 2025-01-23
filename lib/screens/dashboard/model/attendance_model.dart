class Punch {
  final String title;
  final String start;
  final String totalTime;

  Punch({required this.title, required this.start, required this.totalTime});

  factory Punch.fromJson(Map<String, dynamic> json) {
    return Punch(
      title: json['title'],
      start: json['start'],
      totalTime: json['total_time'] ?? '', // If total_time is null, we set it to an empty string
    );
  }
}
