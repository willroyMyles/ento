import 'dart:convert';

import 'package:ento/backend/enums/ageGroup.dart';
import 'package:ento/backend/enums/gender.dart';

class UserData {
  String id;
  String email;
  Gender gender;
  AgeGroup ageGroup;
  String? token;

  UserData({
    required this.id,
    required this.email,
    this.gender = Gender.OTHER,
    this.ageGroup = AgeGroup.ZERO_TO_TWENTY,
    this.token,
  });

  UserData copyWith({
    String? id,
    String? email,
    Gender? gender,
    AgeGroup? ageGroup,
    String? token,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'gender': gender.toMap(),
      'ageGroup': ageGroup.toMap(),
      'token': token,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] == null
          ? Gender.OTHER
          : Gender.OTHER.fromMap(map['gender']),
      ageGroup: map['ageGroup'] == null
          ? AgeGroup.ZERO_TO_TWENTY
          : AgeGroup.ZERO_TO_TWENTY.fromMap(map['ageGroup']),
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(id: $id, email: $email, gender: $gender, ageGroup: $ageGroup, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.id == id &&
        other.email == email &&
        other.gender == gender &&
        other.ageGroup == ageGroup &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        ageGroup.hashCode ^
        token.hashCode;
  }
}
