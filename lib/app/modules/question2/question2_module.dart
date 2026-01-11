import 'package:desafio_target/app/modules/question2/question2_page.dart';
import 'package:desafio_target/app/modules/question2/question2_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Question2Module extends Module {
  @override
  void binds(Injector i) {
    i.add<Question2Store>(Question2Store.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const Question2Page());
  }
}
