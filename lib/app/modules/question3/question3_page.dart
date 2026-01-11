import 'package:desafio_target/app/modules/question3/model/day_model.dart';
import 'package:desafio_target/app/modules/question3/model/month_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_target/app/modules/question3/question3_store.dart';
import 'package:flutter/material.dart';

import '../../shared/utils/utils.dart';

class Question3Page extends StatefulWidget {
  final String title;
  const Question3Page({super.key, this.title = 'Pergunta Nº 3'});
  @override
  Question3PageState createState() => Question3PageState();
}

class Question3PageState extends State<Question3Page> {
  final Question3Store store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.setBilling();
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
              child: Column(
                spacing: 15,
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text(
                        "3) Dado um vetor que guarda o valor de faturamento "
                        "diário de uma distribuidora de todos os dias de um ano, "
                        "faça um programa, na linguagem que desejar, "
                        "que calcule e retorne: ",
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
                        "- O menor valor de faturamento ocorrido em um dia do ano (ignorando os dias com valor 0)",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Builder(
                        builder: (context) {
                          MonthModel month = store.getMonthWithLowestValue();
                          DayModel day = store.getLowValueOfMonth(month);
                          return Column(
                            children: [
                              Text("Dia ${day.day} de ${month.month}"),
                              Text(Utils.formatToReal(day.value)),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        "- O maior valor de faturamento ocorrido em um dia do ano",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Builder(
                        builder: (context) {
                          MonthModel month = store.getMonthWithHighestValue();
                          DayModel day = store.getHighValueOfMonth(month);
                          return Column(
                            children: [
                              Text("Dia ${day.day} de ${month.month}"),
                              Text(Utils.formatToReal(day.value)),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        "- Número de dias no ano em que o valor de faturamento diário foi superior à média anual. ",
                        style: TextStyle(
                          fontSize: constraints.maxWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Builder(
                        builder: (context) {
                          double annualAverage = store.getAnnualAverage();
                          return Column(
                            children: [
                              Text("Média diária ao ano"),
                              Text(Utils.formatToReal(annualAverage)),
                              Text("Quantos dias o valor foi maior que a média anual"),
                              Text("${store.countDaysAboveAnnualAverage()} Dias"),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  Card(
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Detalhes')),
                          DataColumn(label: Text('Mês')),
                          DataColumn(label: Text('Valor')),
                        ],
                        rows: store.billing.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text(
                                            'Faturamento diário - ${item.month}',
                                          ),
                                          content: SizedBox(
                                            width: constraints.maxWidth,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: item.days.length,
                                              itemBuilder: (context, index) {
                                                final day = item.days[index];
                                                return ListTile(
                                                  title: Text('Dia ${day.day}'),
                                                  trailing: Text(
                                                    Utils.formatToReal(day.value),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.insert_drive_file_outlined),
                                ),
                              ),
                              DataCell(Text(item.month)),
                              DataCell(Text(Utils.formatToReal(store.totalMonth(item)))),
                            ],
                          );
                        }).toList(),
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
