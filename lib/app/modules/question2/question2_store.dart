import 'package:mobx/mobx.dart';

part 'question2_store.g.dart';

// ignore: library_private_types_in_public_api
class Question2Store = _Question2StoreBase with _$Question2Store;

abstract class _Question2StoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
