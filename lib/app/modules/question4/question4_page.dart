import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_target/app/modules/question4/question4_store.dart';
import 'package:flutter/material.dart';

import 'pages/question_page.dart';
import 'pages/requirements_desistions_page.dart';
import 'pages/sql_test_page.dart';

class Question4Page extends StatefulWidget {
  final String title;
  const Question4Page({super.key, this.title = 'Pergunta Nº 4'});
  @override
  Question4PageState createState() => Question4PageState();
}

class Question4PageState extends State<Question4Page> {
  final Question4Store store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(title: Text(widget.title)),

          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView(
              controller: store.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                QuestionPage(constraints: constraints),
                RequirementsDesistionsPage(constraints: constraints),
                SqlTestPage(constraints: constraints),
              ],
            ),
          ),
        );
      },
    );
  }
}
