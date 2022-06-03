import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> complains = FirebaseFirestore.instance
        .collection("complains")
        .orderBy("setor")
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

            var resolved = 0;
            for (var i in data.docs) {
              if (i['resolved'] == true) {
                resolved += 1;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  const Text(
                    'Estatísticas',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  const Divider(),
                  Text('Total de reclamações: ${data.size}'),
                  Text('Reclamações resolvidas: $resolved')
                ],
              ),
            );
          }),
    );
  }
}
