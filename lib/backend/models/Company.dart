import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ento/backend/models/CompanyLocation.dart';

class Company {
  String id;
  String email;
  String name;
  String? website;
  String? logo;
  String? backdrop;
  String? contact;
  List<CompanyLocation>? locations = [];

  factory Company.empty() => Company(id: "", email: "", name: "");

  Company({
    required this.id,
    required this.email,
    required this.name,
    this.website,
    this.logo,
    this.backdrop,
    this.contact,
    this.locations,
  });

  Company copyWith({
    String? id,
    String? email,
    String? name,
    String? website,
    String? logo,
    String? backdrop,
    String? contact,
    List<CompanyLocation>? locations,
  }) {
    return Company(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      website: website ?? this.website,
      logo: logo ?? this.logo,
      backdrop: backdrop ?? this.backdrop,
      contact: contact ?? this.contact,
      locations: locations ?? this.locations,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'website': website,
      'logo': logo,
      'backdrop': backdrop,
      'contact': contact,
      'locations': locations?.map((x) => x.toMap()).toList(),
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      website: map['website'],
      logo: map['logo'],
      backdrop: map['backdrop'],
      contact: map['contact'],
      locations: map['locations'] != null
          ? List<CompanyLocation>.from(
              map['locations']?.map((x) => CompanyLocation.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Company(id: $id, email: $email, name: $name, website: $website, logo: $logo, backdrop: $backdrop, contact: $contact, locations: $locations)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.website == website &&
        other.logo == logo &&
        other.backdrop == backdrop &&
        other.contact == contact &&
        listEquals(other.locations, locations);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        website.hashCode ^
        logo.hashCode ^
        backdrop.hashCode ^
        contact.hashCode ^
        locations.hashCode;
  }

  isCompanyInList(List<String> ids) => ids.contains(this.id);
}
