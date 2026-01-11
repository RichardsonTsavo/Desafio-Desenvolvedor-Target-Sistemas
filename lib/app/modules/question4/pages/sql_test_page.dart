import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../question4_store.dart';

class SqlTestPage extends StatefulWidget {
  final BoxConstraints constraints;
  const SqlTestPage({super.key, required this.constraints});

  @override
  State<SqlTestPage> createState() => _SqlTestPageState();
}

class _SqlTestPageState extends State<SqlTestPage> {
  final Question4Store store = Modular.get();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    store.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.label),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            label: 'Cadastrar tipos de telefone',
            onTap: () {
              final formKeyPhone = GlobalKey<FormBuilderState>();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  scrollable: true,
                  title: Text(
                    "Criar novo tipos de telefone",
                    textAlign: TextAlign.center,
                  ),
                  content: FormBuilder(
                    key: formKeyPhone,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FormBuilderTextField(
                          name: "name",
                          decoration: InputDecoration(labelText: "Nome"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o nome";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        if (formKeyPhone.currentState!.saveAndValidate()) {
                          Navigator.of(context).pop();
                          Map<String, dynamic> data = formKeyPhone.currentState!.value;
                          store.createPhoneTypes(name: data["name"]);
                        }
                      },
                      child: Text("Criar"),
                    ),
                  ],
                ),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.map),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            label: 'Cadastrar novos estados',
            onTap: () {
              final formKeyState = GlobalKey<FormBuilderState>();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  scrollable: true,
                  title: Text("Criar novo estado", textAlign: TextAlign.center),
                  content: FormBuilder(
                    key: formKeyState,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FormBuilderTextField(
                          name: "name",
                          decoration: InputDecoration(labelText: "Nome"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Informe o nome";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        FormBuilderTextField(
                          name: "uf",
                          decoration: InputDecoration(labelText: "UF"),
                          inputFormatters: [LengthLimitingTextInputFormatter(2)],
                        ),
                      ],
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        if (formKeyState.currentState!.saveAndValidate()) {
                          Navigator.of(context).pop();
                          Map<String, dynamic> data = formKeyState.currentState!.value;
                          store.createState(name: data["name"], uf: data["uf"]);
                        }
                      },
                      child: Text("Criar"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: const EdgeInsets.all(12),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    const SizedBox(height: 8),
                    FormBuilderTextField(
                      name: 'razao_social',
                      decoration: const InputDecoration(labelText: 'Razão social'),
                    ),
                    const SizedBox(height: 8),
                    Observer(
                      builder: (context) {
                        return Row(
                          children: [
                            Expanded(
                              child: FormBuilderDropdown<String>(
                                name: 'uf',
                                decoration: const InputDecoration(labelText: 'UF'),
                                items: [
                                  for (var element in store.states)
                                    DropdownMenuItem(
                                      value: element.uf,
                                      child: Text(element.uf!),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FormBuilderDropdown(
                                name: 'phoneTypeID',
                                decoration: const InputDecoration(labelText: 'Tipo'),
                                items: [
                                  for (var element in store.phoneTypes)
                                    DropdownMenuItem(
                                      value: element.id!,
                                      child: Text(element.name!),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.search),
                        label: const Text('Buscar'),
                        onPressed: () {
                          _formKey.currentState?.save();
                          store.search(_formKey.currentState?.value ?? {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Observer(
              builder: (_) {
                if (store.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (store.clients.isEmpty) {
                  return const Center(child: Text('Nenhum resultado'));
                }

                return ListView.builder(
                  itemCount: store.clients.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (_, i) {
                    final c = store.clients[i];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(c.razaoSocial!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nome: ${c.name}'),
                            Text('UF: ${c.uf}'),
                            for (var element in c.phones!.map((e) => e).toList()) ...[
                              Divider(),
                              Text(
                                'Telefone:\n'
                                'Número: ${element.number}\n'
                                'Tipo: ${store.phoneTypes.where((e) => e.id == element.phoneTypeId).first.name}',
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
