import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClientFilterModel {
  final String? name;
  final String? razaoSocial;
  final String? uf;
  final int? phoneTypeID;
  ClientFilterModel({this.name, this.razaoSocial, this.uf, this.phoneTypeID});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'razao_social': razaoSocial,
      'uf': uf,
      'phoneTypeID': phoneTypeID,
    };
  }

  factory ClientFilterModel.fromMap(Map<String, dynamic> map) {
    return ClientFilterModel(
      name: map['name'] != null ? map['name'] as String : null,
      razaoSocial: map['razao_social'] != null ? map['razao_social'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      phoneTypeID: map['phoneTypeID'] != null ? map['phoneTypeID'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientFilterModel.fromJson(String source) =>
      ClientFilterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
