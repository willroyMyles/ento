import 'dart:convert';

class CompanyLocation {
  String id;
  String address;
  String hours;
  String contact;
  bool preffered = false;
  CompanyLocation({
    required this.id,
    required this.address,
    required this.hours,
    required this.contact,
    required this.preffered,
  });

  CompanyLocation copyWith({
    String? id,
    String? address,
    String? hours,
    String? contact,
    bool? preffered,
  }) {
    return CompanyLocation(
      id: id ?? this.id,
      address: address ?? this.address,
      hours: hours ?? this.hours,
      contact: contact ?? this.contact,
      preffered: preffered ?? this.preffered,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'hours': hours,
      'contact': contact,
      'preffered': preffered,
    };
  }

  factory CompanyLocation.fromMap(Map<String, dynamic> map) {
    return CompanyLocation(
      id: map['id'] ?? '',
      address: map['address'] ?? '',
      hours: map['hours'] ?? '',
      contact: map['contact'] ?? '',
      preffered: map['preffered'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyLocation.fromJson(String source) =>
      CompanyLocation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyLocation(id: $id, address: $address, hours: $hours, contact: $contact, preffered: $preffered)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyLocation &&
        other.id == id &&
        other.address == address &&
        other.hours == hours &&
        other.contact == contact &&
        other.preffered == preffered;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        address.hashCode ^
        hours.hashCode ^
        contact.hashCode ^
        preffered.hashCode;
  }
}
