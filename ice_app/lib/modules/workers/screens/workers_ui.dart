import 'package:flutter/material.dart';

class Workers extends StatefulWidget {
  const Workers({ Key? key }) : super(key: key);

  @override
  State<Workers> createState() => _WorkersState();
}

class _WorkersState extends State<Workers> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Funcionários'));
  }
}