import 'dart:convert';

import 'package:flutter/foundation.dart';

class NotificationStatistics {
  String id;
  String? notificationId;
  String? companyId;
  int totalViews = 0;
  late List<String> emails = [];
  int emailCount = 0;
  int conversions = 0;

  factory NotificationStatistics.empty() => NotificationStatistics(
      id: "", totalViews: 0, emails: [], emailCount: 0, conversions: 0);

  NotificationStatistics({
    required this.id,
    this.notificationId,
    this.companyId,
    required this.totalViews,
    required this.emails,
    required this.emailCount,
    required this.conversions,
  });

  NotificationStatistics copyWith({
    String? id,
    String? notificationId,
    String? companyId,
    int? totalViews,
    List<String>? emails,
    int? emailCount,
    int? conversions,
  }) {
    return NotificationStatistics(
      id: id ?? this.id,
      notificationId: notificationId ?? this.notificationId,
      companyId: companyId ?? this.companyId,
      totalViews: totalViews ?? this.totalViews,
      emails: emails ?? this.emails,
      emailCount: emailCount ?? this.emailCount,
      conversions: conversions ?? this.conversions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'notificationId': notificationId,
      'companyId': companyId,
      'totalViews': totalViews,
      'emails': emails,
      'emailCount': emailCount,
      'conversions': conversions,
    };
  }

  factory NotificationStatistics.fromMap(Map<String, dynamic> map) {
    return NotificationStatistics(
      id: map['id'] ?? '',
      notificationId: map['notificationId'],
      companyId: map['companyId'],
      totalViews: map['totalViews']?.toInt() ?? 0,
      emails: List<String>.from(map['emails']),
      emailCount: map['emailCount']?.toInt() ?? 0,
      conversions: map['conversions']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationStatistics.fromJson(String source) =>
      NotificationStatistics.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationStatistics(id: $id, notificationId: $notificationId, companyId: $companyId, totalViews: $totalViews, emails: $emails, emailCount: $emailCount, conversions: $conversions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationStatistics &&
        other.id == id &&
        other.notificationId == notificationId &&
        other.companyId == companyId &&
        other.totalViews == totalViews &&
        listEquals(other.emails, emails) &&
        other.emailCount == emailCount &&
        other.conversions == conversions;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        notificationId.hashCode ^
        companyId.hashCode ^
        totalViews.hashCode ^
        emails.hashCode ^
        emailCount.hashCode ^
        conversions.hashCode;
  }
}
