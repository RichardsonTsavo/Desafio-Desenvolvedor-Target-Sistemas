import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_target/app/modules/question1/question1_store.dart';
import 'package:flutter/material.dart';

class Question1Page extends StatefulWidget {
  final String title;
  const Question1Page({super.key, this.title = 'Pergunta Nº 1'});
  @override
  Question1PageState createState() => Question1PageState();
}

class Question1PageState extends State<Question1Page> {
  final Question1Store store = Modular.get();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    store.setInfo(isInit: true);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  spacing: 15,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text(
                          "1) Observe o trecho de código:\n"
                          "Ao final do processamento, qual será o valor da variável SOMA? ",
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "int INDICE = 12, SOMA = 0, K = 1;\n"
                          "enquanto K < INDICE faça\n"
                          "{ K = K + 1; SOMA = SOMA + K;} \n"
                          "imprimir(SOMA); ",
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    FormBuilderTextField(
                      name: "INDICE",
                      initialValue: "12",
                      decoration: InputDecoration(labelText: "Informe o INDICE"),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe um digito valido!";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderTextField(
                      name: "SOMA",
                      initialValue: "0",
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe um digito valido!";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Informe a SOMA"),
                    ),
                    FormBuilderTextField(
                      name: "K",
                      initialValue: "1",
                      decoration: InputDecoration(labelText: "Informe o K"),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Informe um digito valido!";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          Map<String, dynamic> data = _formKey.currentState!.value;
                          store.setInfo(
                            indice: int.tryParse(data["INDICE"]) ?? 12,
                            soma: int.tryParse(data["SOMA"]) ?? 0,
                            k: int.tryParse(data["K"]) ?? 1,
                          );
                        }
                      },
                      child: Text("Testar valores"),
                    ),
                    Observer(
                      builder: (context) {
                        return Card(
                          child: SizedBox(
                            width: constraints.maxWidth,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Iteração')),
                                DataColumn(label: Text('K')),
                                DataColumn(label: Text('SOMA')),
                                DataColumn(label: Text('ÍNDICE')),
                              ],
                              rows: List.generate(store.interactions.length, (index) {
                                final data = store.interactions[index];

                                return DataRow(
                                  cells: [
                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text(data['k'].toString())),
                                    DataCell(Text(data['soma'].toString())),
                                    DataCell(Text(data['indice'].toString())),
                                  ],
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                    Observer(
                      builder: (context) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              "Valor final de soma: ${store.interactions.last["soma"]}",
                              style: TextStyle(
                                fontSize: constraints.maxWidth * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Card(
                      child: ListTile(
                        title: Text(
                          "Explicação: A pergunta pede que, enquanto K < INDICE, "
                          "seja feita uma iteração, a melhor forma de lidar com esse tipo de repetição"
                          " é usando loops, então foi utilizado um while, onde a cada execução K"
                          " é incrementado e somado à variável SOMA. Se colocarmos em uma analogia,"
                          "SOMA funciona como o total gasto em um supermercado durante o mês, "
                          "enquanto K representa cada ida ao mercado, acumulando o valor final.",
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
