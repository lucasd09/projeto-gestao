import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var selectedValue = "Setor 1";

  var db = FirebaseFirestore.instance.collection('complains');
  var db1 = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    final Stream<QuerySnapshot> complains = FirebaseFirestore.instance
        .collection("complains")
        .where("setor", isEqualTo: selectedValue)
        .where("resolved", isEqualTo: false)
        .snapshots();

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

            return StreamBuilder(
                stream: users,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('ERRO');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final userData = snapshot.requireData;

                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton(
                                value: selectedValue,
                                items: dropdownItems,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const Divider(thickness: 1),
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.size,
                              itemBuilder: (context, index) {
                                if (data.docs[index]['company'] ==
                                    userData.docs[0]['company']) {
                                  return Column(
                                    children: [
                                      ListTile(
                                          title:
                                              Text(data.docs[index]['title']),
                                          subtitle:
                                              Text(data.docs[index]['setor'])),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data.docs[index]['body']),
                                            IconButton(
                                                onPressed: () {
                                                  // set up the buttons
                                                  Widget cancelButton =
                                                      TextButton(
                                                    child:
                                                        const Text("Cancelar"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  );
                                                  Widget continueButton =
                                                      TextButton(
                                                    child:
                                                        const Text("Continuar"),
                                                    onPressed: () {
                                                      db
                                                          .doc(data.docs[index]
                                                                  ['id']
                                                              .toString())
                                                          .update({
                                                        "resolved":
                                                            !data.docs[index]
                                                                ['resolved']
                                                      });
                                                      Navigator.of(context)
                                                          .pop();

                                                      final snackBar = SnackBar(
                                                        content: const Text(
                                                            'Reclamação resolvida com Sucesso!'),
                                                        action: SnackBarAction(
                                                          label: 'Fechar',
                                                          onPressed: () {
                                                            db
                                                                .doc(data
                                                                    .docs[index]
                                                                        ['id']
                                                                    .toString())
                                                                .update({
                                                              "resolved": !data
                                                                          .docs[
                                                                      index]
                                                                  ['resolved']
                                                            });
                                                          },
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    },
                                                  );
                                                  // set up the AlertDialog
                                                  AlertDialog alert =
                                                      AlertDialog(
                                                    title: const Text("Aviso"),
                                                    content: const Text(
                                                        "Tem certeza que quer resolver essa reclamação?"),
                                                    actions: [
                                                      cancelButton,
                                                      continueButton,
                                                    ],
                                                  );

                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                },
                                                icon: Icon(data.docs[index]
                                                        ['resolved']
                                                    ? Icons.check_box
                                                    : Icons
                                                        .check_box_outline_blank))
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  );
                                }
                                return const Padding(
                                    padding: EdgeInsets.all(0));
                              }),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
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
