import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'question1_store.g.dart';

// ignore: library_private_types_in_public_api
class Question1Store = _Question1StoreBase with _$Question1Store;

abstract class _Question1StoreBase with Store {
  ObservableList<Map<String, int>> interactions = ObservableList();

  @action
  void setInfo({int indice = 12, int soma = 0, int k = 1, bool isInit = false}) {
    if (k > indice) {
      alert(message: "O valor de (K) não pode ser maior que (INDICE)");
      return;
    }
    interactions.clear();
    while (k < indice) {
      k = k + 1;
      soma = soma + k;
      interactions.add({"k": k, "soma": soma, "indice": indice});
    }
    if (!isInit) {
      alert(message: "Valores atualizados");
    }
  }

  void alert({required String message}) {
    showDialog(
      context: Modular.routerDelegate.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text("Alerta"),
          content: Text(message),
          actionsAlignment: MainAxisAlignment.center,
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
