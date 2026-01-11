// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'phone_model.dart';

class ClientModel {
  final int? id;
  final String? name;
  final String? razaoSocial;
  final String? email;
  final int? stateId;
  final String? uf;
  final DateTime? createdAt;
  final List<PhoneModel>? phones;

  ClientModel(
    this.id,
    this.name,
    this.razaoSocial,
    this.email,
    this.stateId,
    this.uf,
    this.createdAt,
    this.phones,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'razao_social': razaoSocial,
      'email': email,
      'stateId': stateId,
      'uf': uf,
      'createdAt': createdAt?.toIso8601String(),
      'phones': phones?.map((x) => x.toMap()).toList(),
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      map['id'] != null ? map['id'] as int : null,
      map['name'] != null ? map['name'] as String : null,
      map['razao_social'] != null ? map['razao_social'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['stateId'] != null ? map['stateId'] as int : null,
      map['uf'] != null ? map['uf'] as String : null,
      map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      map['phones'] != null
          ? List<PhoneModel>.from(
              (map['phones'] as List<dynamic>).map<PhoneModel?>(
                (x) => PhoneModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ClientModel copyWith({
    int? id,
    String? name,
    String? razaoSocial,
    String? email,
    int? stateId,
    String? uf,
    DateTime? createdAt,
    List<PhoneModel>? phones,
  }) {
    return ClientModel(
      id ?? this.id,
      name ?? this.name,
      razaoSocial ?? this.razaoSocial,
      email ?? this.email,
      stateId ?? this.stateId,
      uf ?? this.uf,
      createdAt ?? this.createdAt,
      phones ?? this.phones,
    );
  }
}
