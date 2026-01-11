import 'package:mobx/mobx.dart';

part 'question5_store.g.dart';

// ignore: library_private_types_in_public_api
class Question5Store = _Question5StoreBase with _$Question5Store;

abstract class _Question5StoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
