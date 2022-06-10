// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ice_app/constants/app_constants.dart';
import 'package:provider/provider.dart';

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

  final db = FirebaseFirestore.instance;

  // Future<List<DropdownMenuItem<String>>> get dropdownItems async {
  //   List<DropdownMenuItem<String>> menuItems = [];
  //   for (var i = 1; i < 5; i++) {
  //     await db.collection('sectors').doc(i.toString()).get().then((value) => {
  //       menuItems.add(DropdownMenuItem(
  //         child: Text(value[i]['name']), value: value[i]['name']))
  //     });
  //   }
  //   return menuItems;
  // }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(child: Text('Setor 1'), value: 'Setor 1'),
      DropdownMenuItem(child: Text('Setor 2'), value: 'Setor 2'),
      DropdownMenuItem(child: Text('Setor 3'), value: 'Setor 3'),
      DropdownMenuItem(child: Text('Setor 4'), value: 'Setor 4')
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    final firebaseUser = context.watch<User?>();
    final Stream<QuerySnapshot> complains =
        FirebaseFirestore.instance.collection("complains").snapshots();

    final Stream<QuerySnapshot> users = FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: firebaseUser?.email)
        .snapshots();

    return Center(
      child: StreamBuilder<QuerySnapshot>(
          stream: complains,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('ERRO');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final data = snapshot.requireData;

            return SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
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
                            child: StreamBuilder(
                                stream: users,
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('ERRO');
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  final userData = snapshot.requireData;

                                  return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: PrimaryColor,
                                          fixedSize: const Size(155, 40)),
                                      onPressed: () {
                                        final postID = data.size + 1;

                                        var complain = <String, dynamic>{
                                          "id": postID,
                                          "title": complainTitle.text.trim(),
                                          "setor": selectedValue1,
                                          "body": complainBody.text.trim(),
                                          "resolved": false,
                                          "company": userData.docs[0]
                                              ["company"],
                                        };

                                        db
                                            .collection("complains")
                                            .doc(postID.toString())
                                            .set(complain);

                                        complainBody.clear();
                                        complainTitle.clear();

                                        final snackBar = SnackBar(
                                          content: const Text(
                                              'Lançamento realizado com Sucesso!'),
                                          action: SnackBarAction(
                                            label: 'Fechar',
                                            onPressed: () {
                                              // Some code to undo the change.
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                      child: const Text(
                                        'Lançar',
                                        style: TextStyle(fontSize: 18),
                                      ));
                                }),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 25)),
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
                                    primary: PrimaryColor,
                                    fixedSize: const Size(155, 40)),
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
                                    content: const Text(
                                        'Funcionário Cadastrado com Sucesso!'),
                                    action: SnackBarAction(
                                      label: 'Fechar',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: const Text(
                                  'Cadastrar',
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
