import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PhoneModel {
  final int? id;
  final int? clientId;
  final int? phoneTypeId;
  final String? number;
  PhoneModel({this.id, this.clientId, this.phoneTypeId, this.number});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'clientId': clientId,
      'phoneTypeId': phoneTypeId,
      'number': number,
    };
  }

  factory PhoneModel.fromMap(Map<String, dynamic> map) {
    return PhoneModel(
      id: map['id'] != null ? map['id'] as int : null,
      clientId: map['client_id'] != null ? map['client_id'] as int : null,
      phoneTypeId: map['phone_type_id'] != null ? map['phone_type_id'] as int : null,
      number: map['number'] != null ? map['number'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneModel.fromJson(String source) =>
      PhoneModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PhoneModel copyWith({int? id, int? clientId, int? phoneTypeId, String? number}) {
    return PhoneModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      phoneTypeId: phoneTypeId ?? this.phoneTypeId,
      number: number ?? this.number,
    );
  }
}
