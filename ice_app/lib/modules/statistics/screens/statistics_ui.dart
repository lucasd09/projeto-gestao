import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ice_app/constants/app_constants.dart';
import 'package:provider/provider.dart';

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

            loadData() {
              return List.generate(data.size, (i) {
                return PieChartSectionData(color: PrimaryColor);
              });
            }

            Widget loadGrafico() {
              return Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(PieChartData(
                        sectionsSpace: 5,
                        centerSpaceRadius: 110,
                        sections: loadData())),
                  )
                ],
              );
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

                        var resolved = 0;
                        var size = 0;

                        for (var i in data.docs) {
                          if (i['company'] == userData.docs[0]['company']) {
                            size += 1;
                            if (i['resolved'] == true) {
                              resolved += 1;
                            }
                          }
                        }

                        return Column(
                          children: [
                            Text('Total de reclamações: $size'),
                            Text('Reclamações resolvidas: $resolved'),
                          ],
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }
}
