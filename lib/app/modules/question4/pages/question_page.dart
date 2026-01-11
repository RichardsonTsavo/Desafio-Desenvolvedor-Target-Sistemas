import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../question4_store.dart';

class QuestionPage extends StatelessWidget {
  final BoxConstraints constraints;
  const QuestionPage({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final Question4Store store = Modular.get();
    return SingleChildScrollView(
      child: Column(
        spacing: 15,
        children: [
          Card(
            child: ListTile(
              title: Text(
                "4) Banco de dados\n\n"
                "Uma empresa solicitou a você um aplicativo para manutenção de um cadastro de clientes. "
                "Após a reunião de definição dos requisitos, as conclusões foram as seguintes:\n\n"
                "- Um cliente pode ter um número ilimitado de telefones;\n"
                "- Cada telefone de cliente tem um tipo, por exemplo: comercial, residencial, celular, etc. "
                "O sistema deve permitir cadastrar novos tipos de telefone;\n"
                "- A princípio, é necessário saber apenas em qual estado brasileiro cada cliente se encontra. "
                "O sistema deve permitir cadastrar novos estados.\n\n"
                "Você ficou responsável pela parte da estrutura de banco de dados que será usada pelo aplicativo. Assim sendo:\n\n"
                "- Proponha um modelo lógico para o banco de dados que vai atender a aplicação. "
                "Desenhe as tabelas necessárias, os campos de cada uma e marque com setas os relacionamentos existentes entre as tabelas;\n"
                "- Aponte os campos que são chave primária (PK) e chave estrangeira (FK);\n"
                "- Faça uma busca utilizando comando SQL que traga o código, a razão social e o(s) telefone(s) de todos os clientes do estado de São Paulo (código “SP”);",
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              store.pageController.nextPage(
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 300),
              );
            },
            child: Text("Resposta"),
          ),
        ],
      ),
    );
  }
}
