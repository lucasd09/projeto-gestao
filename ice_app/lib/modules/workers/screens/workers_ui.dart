import 'package:flutter/material.dart';

class Workers extends StatefulWidget {
  const Workers({ Key? key }) : super(key: key);

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  @override
  Widget build(BuildContext context) {
    return Center(child: ListView.builder(itemCount: 25,itemBuilder: (context, index) {
      return const ListTile(title: Text('dale'),);
    },));
  }
}