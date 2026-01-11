import 'package:desafio_target/app/modules/question4/models/client_model.dart';
import 'package:desafio_target/app/modules/question4/models/phone_model.dart';
import 'package:desafio_target/app/modules/question4/models/phone_type_model.dart';
import 'package:desafio_target/app/modules/question4/models/state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'models/client_filter_model.dart';
import 'repository/question4_repository.dart';

part 'question4_store.g.dart';

// ignore: library_private_types_in_public_api
class Question4Store = _Question4StoreBase with _$Question4Store;

abstract class _Question4StoreBase with Store {
  Question4Repository repository = Question4Repository();
  PageController pageController = PageController();

  ObservableList<ClientModel> clients = ObservableList();
  ObservableList<StateModel> states = ObservableList();
  ObservableList<PhoneType> phoneTypes = ObservableList();
  bool isLoading = false;

  @action
  Future onInit() async {
    await repository.init();
    states.clear();
    phoneTypes.clear();
    states.addAll(
      (await repository.getAllState()).map((e) {
        return StateModel.fromMap(e);
      }).toList(),
    );
    phoneTypes.addAll(
      (await repository.getAllPhoneTypes()).map((e) {
        return PhoneType.fromMap(e);
      }).toList(),
    );

    if (states.isEmpty || phoneTypes.isEmpty) {
      await createFakeData();
      await search({});
    } else {
      await search({});
    }
  }

  @action
  Future<void> search(Map<String, dynamic> form) async {
    if (isLoading) {
      return;
    }
    isLoading = true;

    try {
      final filter = ClientFilterModel.fromMap(form);
      final clientData = await repository.getClients(
        name: filter.name,
        razaoSocial: filter.razaoSocial,
        uf: filter.uf,
        phoneTypeID: filter.phoneTypeID,
      );

      final clientsData = await Future.wait(
        clientData.map((e) async {
          final client = ClientModel.fromMap(e);

          final phoneData = await repository.getPhones(
            clientId: client.id,
            phoneTypeId: filter.phoneTypeID,
          );

          final phones = phoneData.map((p) => PhoneModel.fromMap(p)).toList();

          return client.copyWith(phones: phones);
        }),
      );

      clients
        ..clear()
        ..addAll(clientsData);
    } catch (e) {
      onMensage(message: e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future createState({required String name, required String uf}) async {
    if (isLoading) {
      return;
    }
    try {
      isLoading = true;
      await repository.createState(name: name, uf: uf);
      onInit();
      onMensage(message: "Estado criado com sucesso!", title: "Sucesso!");
    } catch (e) {
      onMensage(message: e.toString());
    } finally {
      isLoading = false;
    }
  }

  Future createPhoneTypes({required String name}) async {
    if (isLoading) {
      return;
    }
    try {
      isLoading = true;
      await repository.createPhoneTypes(name: name);
      await onInit();
      onMensage(message: "Tipos de telefone criado com sucesso!", title: "Sucesso!");
    } catch (e) {
      onMensage(message: e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createFakeData() async {
    if (isLoading) {
      return;
    }
    isLoading = true;

    try {
      for (var element in [
        {"name": "São paulo", "uf": "SP"},
        {"name": "Rio de janeiro", "uf": "RJ"},
        {"name": "Rio Grande do norte", "uf": "RN"},
      ]) {
        await repository.createState(name: element["name"]!, uf: element["uf"]!);
      }
      for (var element in ["Celular", "Comercial", "WhatsApp"]) {
        await repository.createPhoneTypes(name: element);
      }
      states.addAll(
        (await repository.getAllState()).map((e) {
          return StateModel.fromMap(e);
        }).toList(),
      );
      phoneTypes.addAll(
        (await repository.getAllPhoneTypes()).map((e) {
          return PhoneType.fromMap(e);
        }).toList(),
      );
      for (int i = 1; i <= 15; i++) {
        final state = states[i % states.length];

        final clientId = await repository.createClient(
          name: 'Cliente $i',
          razaoSocial: 'Empresa Teste $i LTDA',
          email: 'cliente$i@email.com',
          stateId: state.id!,
        );

        final phonesCount = (i % 3) + 1;

        for (int p = 0; p < phonesCount; p++) {
          final phoneType = phoneTypes[i % phoneTypes.length];
          await repository.createPhone(
            clientId: clientId,
            phoneTypeId: phoneType.id!,
            number: '(11) 9$i${p}00-000$i',
          );
        }
      }

      await search({});
    } catch (e) {
      onMensage(message: e.toString());
    } finally {
      isLoading = false;
    }
  }

  void onMensage({required String message, String title = "Erro"}) {
    showDialog(
      context: Modular.routerDelegate.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
