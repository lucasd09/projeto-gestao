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
  var size, height, width, selectedValue = "Setor 1";

  final complainTitle = TextEditingController();
  final complainBody = TextEditingController();

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
          const Text('Lançamento'),
          const Divider(
            thickness: 1,
          ),
          TextFormField(
            controller: complainTitle,
            decoration: const InputDecoration(
              labelText: 'Título da reclamação',
              border: OutlineInputBorder(),
            ),
          ),
          DropdownButton(
            value: selectedValue,
            items: dropdownItems,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value!;
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
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: PrimaryColor, fixedSize: const Size(155, 40)),
              onPressed: () {
                var complain = <String, dynamic>{
                  "title": complainTitle.text.trim(),
                  "setor": selectedValue,
                  "body": complainBody.text.trim()
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
          ElevatedButton(
              onPressed: () {
                db.collection("sectors").get().then((event) {
                  for (var doc in event.docs) {
                    print("${doc.id} => ${doc.get('title')}");
                  }
                });
              },
              child: const Text('Ler'))
        ],
      ),
    ));
  }
}
