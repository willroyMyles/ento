import 'dart:convert';

import 'package:flutter/foundation.dart';

class ManageNotificationModel {
  String id;
  Map<String, bool> permissions;

  ManageNotificationModel({
    required this.id,
    required this.permissions,
  });

  ManageNotificationModel copyWith({
    String? id,
    Map<String, bool>? permissions,
  }) {
    return ManageNotificationModel(
      id: id ?? this.id,
      permissions: permissions ?? this.permissions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'permissions': permissions,
    };
  }

  factory ManageNotificationModel.fromMap(Map<String, dynamic> map) {
    return ManageNotificationModel(
      id: map['id'] ?? '',
      permissions: Map<String, bool>.from(map['permissions']),
    );
  }

  factory ManageNotificationModel.empty() =>
      ManageNotificationModel(id: "", permissions: {});

  String toJson() => json.encode(toMap());

  factory ManageNotificationModel.fromJson(String source) =>
      ManageNotificationModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ManageNotificationModel(id: $id, permissions: $permissions)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ManageNotificationModel &&
        other.id == id &&
        mapEquals(other.permissions, permissions);
  }

  @override
  int get hashCode => id.hashCode ^ permissions.hashCode;
}
