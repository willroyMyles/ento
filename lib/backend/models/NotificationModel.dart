import 'dart:convert';

class NotificationModel {
  String id;
  String title;
  String? body;
  String? picture;
  int? date = DateTime.now().millisecondsSinceEpoch;
  String? type;

  factory NotificationModel.empty() =>
      NotificationModel(id: "", title: "title");

  NotificationModel({
    required this.id,
    required this.title,
    this.body,
    this.picture,
    this.date,
    this.type,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? picture,
    int? date,
    String? type,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      picture: picture ?? this.picture,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'picture': picture,
      'date': date,
      'type': type,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'],
      picture: map['picture'],
      date: map['date']?.toInt() ?? 0,
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, body: $body, picture: $picture, date: $date, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationModel &&
        other.id == id &&
        other.title == title &&
        other.body == body &&
        other.picture == picture &&
        other.date == date &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        body.hashCode ^
        picture.hashCode ^
        date.hashCode ^
        type.hashCode;
  }
}
