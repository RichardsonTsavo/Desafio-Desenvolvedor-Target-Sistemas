import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../question4_store.dart';

class RequirementsDesistionsPage extends StatelessWidget {
  final BoxConstraints constraints;
  const RequirementsDesistionsPage({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final Question4Store store = Modular.get();
    return SingleChildScrollView(
      child: Column(
        spacing: 8,
        children: [
          Card(
            child: ListTile(
              title: Text(
                "Requisitos/Decisões de modelagem:",
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "1) Um cliente pode ter número ilimitado de telefones\n"
                "   * Relação do tipo 1:N (Um para muitos)\n"
                "   * Telefones em tabela separada",
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "2) Cada telefone tem um tipo\n"
                "   * Tipo não pode ser texto fixo\n"
                "   * Criar tabela phone_types\n"
                "   * Permite cadastrar novos tipos",
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "3) Saber o estado brasileiro do cliente\n"
                "   * Criar tabela states\n"
                "   * Cliente referencia um estado\n"
                "   * Permite cadastrar novos estados",
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "TABELAS FINAIS:\n"
                "- clients\n"
                "- phones\n"
                "- phone_types\n"
                "- states",
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "MODELAGEM (DIAGRAMA MENTAL)",
                      style: TextStyle(
                        fontSize: constraints.maxWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          entityBox(
                            icon: Icons.map,
                            title: 'States',
                            fields: const ['id (PK, AUTO)', 'name (REQ)', 'uf (UNIQUE)'],
                          ),

                          const Icon(Icons.arrow_forward),

                          entityBox(
                            icon: Icons.person,
                            title: 'Clients',
                            fields: const [
                              'id (PK, AUTO)',
                              'name (REQ)',
                              'razao_social (REQ)',
                              'email (UNIQUE)',
                              'state_id (FK, REQ)',
                            ],
                          ),

                          const Icon(Icons.arrow_forward),

                          entityBox(
                            icon: Icons.phone,
                            title: 'Phones',
                            fields: const [
                              'id (PK, AUTO)',
                              'client_id (FK, REQ)',
                              'phone_type_id (FK, REQ)',
                              'number (REQ)',
                            ],
                          ),

                          const Icon(Icons.arrow_forward),

                          entityBox(
                            icon: Icons.label,
                            title: 'Phone Types',
                            fields: const ['id (PK, AUTO)', 'name (UNIQUE)'],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "- PK = chave primária\n"
                      "- FK = chave estrangeira\n"
                      "- AUTO = autoincrement\n"
                      "- UNIQUE = valor único\n"
                      "- REQ = obrigatório (NOT NULL)",
                      style: TextStyle(
                        fontSize: constraints.maxWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "QUERY PROPOSTA PELA PERGUNTA:\n"
                "- Faça uma busca utilizando comando SQL que traga o código, a razão social e o(s) telefone(s) de todos os clientes do estado de São Paulo (código “SP”)\n\n"
                "SELECT\n"
                "    c.id,\n"
                "    c.razao_social,\n"
                "GROUP_CONCAT(p.number, ', ') AS telefones\n"
                "FROM clients c\n"
                "JOIN states s      ON s.id = c.state_id\n"
                "LEFT JOIN phones p ON p.client_id = c.id\n"
                "WHERE s.uf = 'SP'\n"
                "ORDER BY c.razao_social\n",
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "RESPOSTA DA QUERY PROPOSTA:\n"
                "[\n"
                "  {\n"
                "    \"id\": 1,\n"
                "    \"razao_social\": \"Empresa Alpha Ltda\",\n"
                "    \"telefones\": [\n"
                "      \"1199999999\",\n"
                "      \"1133333333\"\n"
                "    ]\n"
                "  },\n"
                "  {\n"
                "    \"id\": 2,\n"
                "    \"razao_social\": \"Empresa Beta ME\",\n"
                "    \"telefones\": [\n"
                "      \"1188888888\"\n"
                "    ]\n"
                "  }\n"
                "]",
                style: TextStyle(
                  fontSize: constraints.maxWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  store.pageController.previousPage(
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 300),
                  );
                },
                child: Text("Voltar"),
              ),
              ElevatedButton(
                onPressed: () {
                  store.pageController.nextPage(
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 300),
                  );
                },
                child: Text("Testar"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget entityBox({
    required IconData icon,
    required String title,
    required List<String> fields,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Icon(icon, size: 28)),
          const SizedBox(height: 8),
          Center(
            child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Divider(),
          ...fields.map(
            (field) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(field, style: const TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}
