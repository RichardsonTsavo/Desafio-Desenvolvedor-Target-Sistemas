import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

import '../../../shared/repository/sql_repository.dart';

class Question4Repository {
  static Database? _db;
  final SqlRepository sqlRepository = Modular.get();

  Future<void> init() async {
    _db = await sqlRepository.getinstance();
  }

  Future<int> createState({required String name, required String uf}) async {
    return await _db!.insert('states', {'name': name, 'uf': uf});
  }

  Future<int> createPhoneTypes({required String name}) async {
    return await _db!.insert('phone_types', {'name': name});
  }

  Future<List<Map<String, dynamic>>> getStates({String? name, String? uf}) async {
    final where = <String>[];
    final args = <Object?>[];

    if (name != null) {
      where.add('name LIKE ?');
      args.add('%$name%');
    }

    if (uf != null) {
      where.add('uf = ?');
      args.add(uf);
    }

    return await _db!.query(
      'states',
      where: where.isNotEmpty ? where.join(' AND ') : null,
      whereArgs: args,
      orderBy: 'name',
    );
  }

  Future<int> createClient({
    required String name,
    required String razaoSocial,
    String? email,
    required int stateId,
  }) async {
    return await _db!.insert('clients', {
      'name': name,
      'razao_social': razaoSocial,
      'email': email,
      'state_id': stateId,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getClients({
    String? name,
    String? razaoSocial,
    String? uf,
    int? phoneTypeID,
  }) async {
    final sql = StringBuffer();
    final args = <Object?>[];

    sql.write('''
      SELECT
        c.id,
        c.name,
        c.razao_social,
        c.email,
        s.uf
      FROM clients c
      JOIN states s ON s.id = c.state_id
    ''');

    if (phoneTypeID != null) {
      sql.write('''
      JOIN phones p ON p.client_id = c.id
      JOIN phone_types pt ON pt.id = p.phone_type_id
    ''');
    }

    sql.write(' WHERE 1 = 1 ');

    if (name != null) {
      sql.write(' AND c.name LIKE ? ');
      args.add('%$name%');
    }

    if (razaoSocial != null) {
      sql.write(' AND c.razao_social LIKE ? ');
      args.add('%$razaoSocial%');
    }

    if (uf != null) {
      sql.write(' AND s.uf = ? ');
      args.add(uf);
    }

    sql.write(' GROUP BY c.id ');
    sql.write(' ORDER BY c.razao_social ');

    return await _db!.rawQuery(sql.toString(), args);
  }

  Future<int> createPhone({
    required int clientId,
    required int phoneTypeId,
    required String number,
  }) async {
    return await _db!.insert('phones', {
      'client_id': clientId,
      'phone_type_id': phoneTypeId,
      'number': number,
    });
  }

  Future<List<Map<String, dynamic>>> getPhones({int? clientId, int? phoneTypeId}) async {
    final where = <String>[];
    final args = <Object?>[];

    if (clientId != null) {
      where.add('client_id = ?');
      args.add(clientId);
    }

    if (phoneTypeId != null) {
      where.add('phone_type_id = ?');
      args.add(phoneTypeId);
    }

    return await _db!.query(
      'phones',
      where: where.isNotEmpty ? where.join(' AND ') : null,
      whereArgs: args,
      orderBy: 'number',
    );
  }

  Future<List<Map<String, dynamic>>> getAllState() async {
    return _db!.query('states');
  }

  Future<List<Map<String, dynamic>>> getAllPhoneTypes() async {
    return _db!.query('phone_types');
  }
}
