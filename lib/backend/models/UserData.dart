import 'dart:convert';

import 'package:ento/backend/enums/ageGroup.dart';
import 'package:ento/backend/enums/gender.dart';

import 'Company.dart';

class UserData {
  String id;
  String email;
  Gender gender;
  AgeGroup ageGroup;
  String? token;
  bool? isCompany = false;
  Company? company;
  List<String>? companyIds = [];

  UserData({
    required this.id,
    required this.email,
    this.gender = Gender.OTHER,
    this.ageGroup = AgeGroup.ZERO_TO_TWENTY,
    this.token,
    this.isCompany,
    this.company,
    this.companyIds = const [],
  });

  UserData copyWith({
    String? id,
    String? email,
    Gender? gender,
    AgeGroup? ageGroup,
    String? token,
    bool? isCompany,
    Company? company,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
      token: token ?? this.token,
      isCompany: isCompany ?? this.isCompany,
      company: company ?? this.company,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'gender': gender.toMap(),
      'ageGroup': ageGroup.toMap(),
      'token': token,
      'isCompany': isCompany,
      'company': company?.toMap(),
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
        isCompany: map['isCompany'],
        company:
            map['Company'] != null ? Company.fromMap(map['Company']) : null,
        companyIds: extractList(map["subscribedCompanies"]));
  }

  static List<String> extractList(List<dynamic>? listOfMaps) {
    if (listOfMaps == null) return [];

    var maps = List<Map<String, dynamic>>.from(listOfMaps);
    List<String> stringlist = [];
    maps.forEach((element) {
      stringlist.add(element.values.first as String);
    });
    return stringlist;
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(id: $id, email: $email, gender: $gender, ageGroup: $ageGroup, token: $token, isCompany: $isCompany, company: $company)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.id == id &&
        other.email == email &&
        other.gender == gender &&
        other.ageGroup == ageGroup &&
        other.token == token &&
        other.isCompany == isCompany &&
        other.company == company;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        ageGroup.hashCode ^
        token.hashCode ^
        isCompany.hashCode ^
        company.hashCode;
  }
}
