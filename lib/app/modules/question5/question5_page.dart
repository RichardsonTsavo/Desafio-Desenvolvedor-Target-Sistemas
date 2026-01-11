import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_target/app/modules/question5/question5_store.dart';
import 'package:flutter/material.dart';

class Question5Page extends StatefulWidget {
  final String title;
  const Question5Page({super.key, this.title = 'Pergunta Nº 5'});
  @override
  Question5PageState createState() => Question5PageState();
}

class Question5PageState extends State<Question5Page> {
  final Question5Store store = Modular.get();

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
                        "5) Dois veículos, um carro e um caminhão, saem respectivamente "
                        "de cidades opostas pela mesma rodovia. O carro, de Ribeirão Preto "
                        "em direção a Barretos, a uma velocidade constante de 90 km/h, e o "
                        "caminhão, de Barretos em direção a Ribeirão Preto, a uma velocidade "
                        "constante de 80 km/h. Quando eles se cruzarem no percurso, qual estará "
                        "mais próximo da cidade de Ribeirão Preto? ",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      title: Text(
                        "a) Dados do problema\n\n"
                        " - Distância entre Ribeirão Preto e Barretos: 125 km\n"
                        " - Velocidade do carro: 90 km/h\n"
                        " - Velocidade do caminhão: 80 km/h",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        "b) Consideração dos pedágios\n\n"
                        " - Existem 3 pedágios\n"
                        " - O carro leva 5 minutos a mais em cada pedágio = 15 min\n"
                        " - O caminhão não sofre atraso, então segue o tempo todo a 80 km/h",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        "Pergunta:\n"
                        " - Quando eles se cruzarem no percurso, qual estará mais "
                        "próximo da cidade de Ribeirão Preto?\n\n"
                        "Resposta:\nAcredito que seja uma pegadinha, pois no momento em que o carro "
                        "e o caminhão se cruzam, ambos estarão à mesma distância da cidade de "
                        "Ribeirão Preto, apenas em sentidos opostos, já que o ponto de encontro é "
                        "único na rodovia, independentemente das velocidades e do atraso do carro nos "
                        "pedágios, que apenas altera o onde vai ser o encontro, não a distancia que os dois vão estar de Ribeirão Preto",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
