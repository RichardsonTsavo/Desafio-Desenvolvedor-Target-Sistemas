import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PhoneType {
  final int? id;
  final String? name;
  PhoneType({this.id, this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory PhoneType.fromMap(Map<String, dynamic> map) {
    return PhoneType(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneType.fromJson(String source) =>
      PhoneType.fromMap(json.decode(source) as Map<String, dynamic>);

  PhoneType copyWith({int? id, String? name}) {
    return PhoneType(id: id ?? this.id, name: name ?? this.name);
  }
}
