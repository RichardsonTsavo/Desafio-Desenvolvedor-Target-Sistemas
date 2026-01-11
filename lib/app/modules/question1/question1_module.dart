import 'package:desafio_target/app/modules/question1/question1_page.dart';
import 'package:desafio_target/app/modules/question1/question1_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Question1Module extends Module {
  @override
  void binds(Injector i) {
    i.add<Question1Store>(Question1Store.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const Question1Page());
  }
}
