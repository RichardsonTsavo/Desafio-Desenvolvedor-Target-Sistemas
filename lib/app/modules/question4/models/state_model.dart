import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class StateModel {
  final int? id;
  final String? name;
  final String? uf;
  StateModel({this.id, this.name, this.uf});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'uf': uf};
  }

  factory StateModel.fromMap(Map<String, dynamic> map) {
    return StateModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateModel.fromJson(String source) =>
      StateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  StateModel copyWith({int? id, String? name, String? uf}) {
    return StateModel(id: id ?? this.id, name: name ?? this.name, uf: uf ?? this.uf);
  }
}
