import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/question1/question1_module.dart';
import 'modules/question2/question2_module.dart';
import 'modules/question3/question3_module.dart';
import 'modules/question4/question4_module.dart';
import 'modules/question5/question5_module.dart';
import 'shared/repository/sql_repository.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<SqlRepository>(SqlRepository.new);
  }

  @override
  void routes(r) {
    r.module('/', module: HomeModule(), transition: TransitionType.fadeIn);
    r.module('/question1/', module: Question1Module(), transition: TransitionType.fadeIn);
    r.module('/question2/', module: Question2Module(), transition: TransitionType.fadeIn);
    r.module('/question3/', module: Question3Module(), transition: TransitionType.fadeIn);
    r.module('/question4/', module: Question4Module(), transition: TransitionType.fadeIn);
    r.module('/question5/', module: Question5Module(), transition: TransitionType.fadeIn);
  }
}
