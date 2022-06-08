// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ice_app/constants/app_constants.dart';

class Launch extends StatefulWidget {
  const Launch({Key? key}) : super(key: key);

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  var size,
      height,
      width,
      selectedValue1 = "Setor 1",
      selectedValue2 = "Setor 1";

  final complainTitle = TextEditingController();
  final complainBody = TextEditingController();
  final workerName = TextEditingController();
  final workerJob = TextEditingController();

  @override
  void dispose() {
    complainTitle.dispose();
    complainBody.dispose();

    super.dispose();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(child: Text('Setor 1'), value: 'Setor 1'),
      DropdownMenuItem(child: Text('Setor 2'), value: 'Setor 2'),
      DropdownMenuItem(child: Text('Setor 3'), value: 'Setor 3'),
      DropdownMenuItem(child: Text('Setor 4'), value: 'Setor 4')
    ];
    return menuItems;
  }

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Center(
        child: SizedBox(
      width: width / 1.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Reclamação'),
          const Divider(
            thickness: 1,
          ),
          TextFormField(
            controller: complainTitle,
            decoration: const InputDecoration(
              labelText: 'Nome do funcionário',
              border: OutlineInputBorder(),
            ),
          ),
          DropdownButton(
            value: selectedValue1,
            items: dropdownItems,
            onChanged: (String? value) {
              setState(() {
                selectedValue1 = value!;
              });
            },
          ),
          TextFormField(
            controller: complainBody,
            decoration: const InputDecoration(
              labelText: 'Reclamação',
              border: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: PrimaryColor, fixedSize: const Size(155, 40)),
                onPressed: () {
                  var complain = <String, dynamic>{
                    "title": complainTitle.text.trim(),
                    "setor": selectedValue1,
                    "body": complainBody.text.trim(),
                    "resolved": false
                  };

                  db.collection("complains").add(complain);

                  complainBody.clear();
                  complainTitle.clear();

                  final snackBar = SnackBar(
                    content: const Text('Lançamento realizado com Sucesso!'),
                    action: SnackBarAction(
                      label: 'Fechar',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text(
                  'Lançar',
                  style: TextStyle(fontSize: 18),
                )),
          ),
          const Padding(padding: EdgeInsets.only(top: 100)),
          const Text('Cadastrar Funcionário'),
          const Divider(),
          TextFormField(
            controller: workerName,
            decoration: const InputDecoration(
              labelText: 'Nome do funcionário',
              border: OutlineInputBorder(),
            ),
          ),
          DropdownButton(
            value: selectedValue2,
            items: dropdownItems,
            onChanged: (String? value) {
              setState(() {
                selectedValue2 = value!;
              });
            },
          ),
          TextFormField(
            controller: workerJob,
            decoration: const InputDecoration(
              labelText: 'Cargo',
              border: OutlineInputBorder(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: PrimaryColor, fixedSize: const Size(155, 40)),
                onPressed: () {
                  var worker = <String, dynamic>{
                    "name": workerName.text.trim(),
                    "setor": selectedValue2,
                    "job": workerJob.text.trim()
                  };

                  db.collection("workers").add(worker);

                  workerName.clear();
                  workerJob.clear();

                  final snackBar = SnackBar(
                    content: const Text('Funcionário Cadastrado com Sucesso!'),
                    action: SnackBarAction(
                      label: 'Fechar',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 18),
                )),
          ),
        ],
      ),
    ));
  }
}
