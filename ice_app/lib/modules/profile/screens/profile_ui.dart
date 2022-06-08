// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ice_app/constants/app_constants.dart';
import 'package:ice_app/core/auth/login/models/auth_service.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var size, height, width;

  final nome = TextEditingController();
  final empresa = TextEditingController();
  final cargo = TextEditingController();
  final email = TextEditingController();

  @override
  void dispose() {
    nome.dispose();
    empresa.dispose();
    cargo.dispose();
    email.dispose();

    super.dispose();
  }

  bool enable = false;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final Stream<QuerySnapshot> users = FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: firebaseUser?.email)
        .snapshots();

    var db = FirebaseFirestore.instance.collection('users');

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Center(
      child: StreamBuilder<QuerySnapshot>(
          stream: users,
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
              width: width / 1.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ice_logo.png',
                        width: 160,
                        height: 160,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              enable = !enable;
                            });
                          },
                          child: const Icon(
                              Icons.drive_file_rename_outline_outlined)),
                      enable
                          ? ElevatedButton(
                              onPressed: () {
                                db.doc(firebaseUser?.email).update({
                                  'company': empresa.text,
                                  'name': nome.text,
                                  'job': cargo.text
                                });

                                nome.clear();
                                empresa.clear();
                                cargo.clear();

                                setState(() {
                                  enable = !enable;
                                });

                                final snackBar = SnackBar(
                                  content: const Text(
                                      'Alterações realizadas com Sucesso!'),
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
                              child: const Icon(Icons.save_outlined))
                          : const Icon(Icons.save_outlined)
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nome:'),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: data.docs[1]['name']),
                        enabled: enable,
                        controller: nome,
                      ),
                      const Divider(),
                      const Text('Empresa:'),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: data.docs[1]['company']),
                        enabled: enable,
                        controller: empresa,
                      ),
                      const Divider(),
                      const Text('Cargo:'),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: data.docs[1]['job']),
                        enabled: enable,
                        controller: cargo,
                      ),
                      const Divider(),
                      const Text('email:'),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: data.docs[1]['email']),
                        enabled: false,
                        controller: email,
                      ),
                    ],
                  ),
                  const Divider(),
                  TextButton.icon(
                    onPressed: () {
                      context.read<AuthService>().signOut();
                    },
                    icon: const Icon(Icons.logout_outlined),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: PrimaryTextColor),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
