class Announcement {
  final String creatorName;
  final String designation;
  final String department;
  final String tmlnTitle;
  final String tmlnContent;
  final String tmlnImage;
  final String tmlnInsertDate;
  final String tmlnInsertBy;
  final String tmlnPostKey;
  final String tmlnStatus;

  Announcement({
    required this.creatorName,
    required this.designation,
    required this.department,
    required this.tmlnTitle,
    required this.tmlnContent,
    required this.tmlnImage,
    required this.tmlnInsertDate,
    required this.tmlnInsertBy,
    required this.tmlnPostKey,
    required this.tmlnStatus,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      creatorName: json['creator_name'] ?? 'Unknown',
      designation: json['designation'] ?? 'Not Available',
      department: json['department'] ?? 'Not Available',
      tmlnTitle: json['tmln_title'] ?? '',
      tmlnContent: json['tmln_content'] ?? "",
      tmlnImage: json['tmln_image'] ?? "",
      tmlnInsertDate: json['tmln_insert_date'] ?? '',
      tmlnInsertBy: json['tmln_insert_by'] ?? '',
      tmlnPostKey: json['tmln_post_key'] ?? "",
      tmlnStatus: json['tmln_status'] ?? '',
    );
  }
}
