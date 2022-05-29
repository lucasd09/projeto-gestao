import 'package:flutter/material.dart';


class Launch extends StatefulWidget {
  const Launch({ Key? key }) : super(key: key);

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: 
      const [Text('Lançamento'),
      Divider(
            thickness: 1,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Nome Sobrenome'),
          ),],
      )
      );
  }
}