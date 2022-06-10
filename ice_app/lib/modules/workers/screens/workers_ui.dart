import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Workers extends StatefulWidget {
  const Workers({Key? key}) : super(key: key);

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  var selectedValue = "Setor 1";

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> complains = FirebaseFirestore.instance
        .collection("workers")
        .where("setor", isEqualTo: selectedValue)
        .snapshots();

    final firebaseUser = context.watch<User?>();
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
                  const Divider(
                    thickness: 1,
                  ),
                  StreamBuilder(
                      stream: users,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('ERRO');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final userData = snapshot.requireData;
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.size,
                              itemBuilder: (context, index) {
                                if (data.docs[index]['company'] ==
                                    userData.docs[0]['company']) {
                                  return Column(
                                    children: [
                                      ListTile(
                                          title: Text(data.docs[index]['name']),
                                          subtitle:
                                              Text(data.docs[index]['setor'])),
                                      Text(data.docs[index]['job']),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  );
                                }
                                return const Padding(
                                    padding: EdgeInsets.all(0));
                              }),
                        );
                      })
                ],
              ),
            );
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
