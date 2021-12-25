import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ento/backend/enums/formType.dart';

class DynamicFormModel {
  FormType type;
  String title;
  String? key;
  String? placeHolder;
  dynamic value;
  bool required = false;
  List<String>? items = [];

  DynamicFormModel({
    required this.type,
    required this.title,
    this.key,
    this.placeHolder,
    required this.value,
    required this.required,
    required this.items,
  });

  DynamicFormModel copyWith({
    FormType? type,
    String? title,
    String? key,
    String? placeHolder,
    dynamic value,
    bool? required,
    List<String>? items,
  }) {
    return DynamicFormModel(
      type: type ?? this.type,
      title: title ?? this.title,
      key: key ?? this.key,
      placeHolder: placeHolder ?? this.placeHolder,
      value: value ?? this.value,
      required: required ?? this.required,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.toMap(),
      'title': title,
      'key': key,
      'placeHolder': placeHolder,
      'value': value,
      'required': required,
      'items': items,
    };
  }

  factory DynamicFormModel.fromMap(Map<String, dynamic> map) {
    return DynamicFormModel(
      type: FormType.TEXT.fromMap(map['type']),
      title: map['title'] ?? '',
      key: map['key'],
      placeHolder: map['placeHolder'],
      value: map['value'] ?? null,
      required: map['required'] ?? false,
      items: map['items'] == null ? null : List<String>.from(map['items']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DynamicFormModel.fromJson(String source) =>
      DynamicFormModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DynamicFormModel(type: $type, title: $title, key: $key, placeHolder: $placeHolder, value: $value, required: $required, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DynamicFormModel &&
        other.type == type &&
        other.title == title &&
        other.key == key &&
        other.placeHolder == placeHolder &&
        other.value == value &&
        other.required == required &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return type.hashCode ^
        title.hashCode ^
        key.hashCode ^
        placeHolder.hashCode ^
        value.hashCode ^
        required.hashCode ^
        items.hashCode;
  }
}
