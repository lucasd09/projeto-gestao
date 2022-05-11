import 'package:flutter/material.dart';

class Launch extends StatefulWidget {
  const Launch({ Key? key }) : super(key: key);

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('lancamento'));
  }
}