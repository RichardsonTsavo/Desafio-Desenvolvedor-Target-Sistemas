import 'package:desafio_target/app/modules/question3/question3_page.dart';
import 'package:desafio_target/app/modules/question3/question3_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Question3Module extends Module {
  @override
  void binds(Injector i) {
    i.add<Question3Store>(Question3Store.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const Question3Page());
  }
}
