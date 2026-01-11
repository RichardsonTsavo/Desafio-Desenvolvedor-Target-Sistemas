import 'package:mobx/mobx.dart';

import '../../shared/models/question_model.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  List<QuestionModel> questions = [
    QuestionModel(title: "Pergunta 01", page: "/question1/"),
    QuestionModel(title: "Pergunta 02", page: "/question2/"),
    QuestionModel(title: "Pergunta 03", page: "/question3/"),
    QuestionModel(title: "Pergunta 04", page: "/question4/"),
    QuestionModel(title: "Pergunta 05", page: "/question5/"),
  ];
}
