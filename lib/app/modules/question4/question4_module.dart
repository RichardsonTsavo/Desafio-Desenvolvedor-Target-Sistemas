import 'package:desafio_target/app/modules/question4/question4_page.dart';
import 'package:desafio_target/app/modules/question4/question4_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Question4Module extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<Question4Store>(Question4Store.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const Question4Page());
  }
}
