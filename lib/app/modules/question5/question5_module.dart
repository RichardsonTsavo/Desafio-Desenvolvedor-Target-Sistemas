import 'package:desafio_target/app/modules/question5/question5_page.dart';
import 'package:desafio_target/app/modules/question5/question5_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Question5Module extends Module {
  @override
  void binds(Injector i) {
    i.add<Question5Store>(Question5Store.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const Question5Page());
  }
}
