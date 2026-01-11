import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_target/app/modules/question2/question2_store.dart';
import 'package:flutter/material.dart';

class Question2Page extends StatefulWidget {
  final String title;
  const Question2Page({super.key, this.title = 'Pergunta Nº2'});
  @override
  Question2PageState createState() => Question2PageState();
}

class Question2PageState extends State<Question2Page> {
  final Question2Store store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 15,
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text(
                        "2) Descubra a lógica e complete o próximo elemento:",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  card(
                    question: 'a) 1, 3, 5, 7,',
                    answare: '9',
                    explanation:
                        "Explicação: A sequência é formada por números ímpares consecutivos "
                        "onde cada número aumenta de 2 em 2 em relação ao anterior, por isso, "
                        "após 7, o próximo número é o 9.",
                  ),
                  card(
                    question: 'b) 2, 4, 8, 16, 32, 64',
                    answare: '128',
                    explanation:
                        "A sequência dobra baseada no número anterior, ou seja, multiplicado por 2, "
                        "por isso, após 64, o próximo número é 128.",
                  ),
                  card(
                    question: 'c) 0, 1, 4, 9, 16, 25, 36,',
                    answare: '49',
                    explanation:
                        "A sequência é formada pelos quadrados dos números "
                        "2 ao quadrado é 4, 3 ao quadrado é 9 e por ai vai, "
                        "portanto o próximo número é 7 ao quadrado = 49.",
                  ),
                  card(
                    question: 'd) 4, 16, 36, 64,',
                    answare: '100',
                    explanation:
                        "Como na anterior o valor é determinado pelo quadrado mas dessa vez só estão os número pares, sendo o proximo número o quadrado de 10 = 100",
                  ),
                  card(
                    question: 'e) 1, 1, 2, 3, 5, 8,',
                    answare: '13',
                    explanation:
                        "A sequencia segue somando dos dois valores anteriores então 5 + 8 = 13",
                  ),
                  card(
                    question: 'e) 2,10, 12, 16, 17, 18, 19,',
                    answare: '20',
                    explanation:
                        "Essa é uma pegadinha, o inicio mostra um padrão mas depois do 16 fica em sequencia então a resposta mais logica seria 20",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget card({
    required String question,
    required String answare,
    required String explanation,
  }) {
    return Card(
      child: ListTile(
        title: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(text: question),
              TextSpan(
                text: ' ___',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Text(
              "Resposta: $answare",
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(explanation, style: const TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
