import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

            return Column(
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
                const Divider(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ListTile(
                                title: Text(data.docs[index]['name']),
                                subtitle: Text(data.docs[index]['setor'])),
                            Text(data.docs[index]['job']),
                            const Divider(),
                          ],
                        );
                      }),
                ),
              ],
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
