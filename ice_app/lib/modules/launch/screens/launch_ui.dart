// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Launch extends StatefulWidget {
  const Launch({Key? key}) : super(key: key);

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  var size, height, width, selectedValue = "Setor 1";

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Center(
        child: SizedBox(
      width: width / 1.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Lançamento'),
          const Divider(
            thickness: 1,
          ),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Título da reclamação',
              border: OutlineInputBorder(),
            ),
          ),
          DropdownButton(
            value: selectedValue,
            items: dropdownItems,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Reclamação',
              border: OutlineInputBorder(),
            ),
          ),
          Submi
        ],
      ),
    ));
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(child: Text("Setor 1"), value: "Setor 1"),
    DropdownMenuItem(child: Text("Setor 2"), value: "Setor 2"),
    DropdownMenuItem(child: Text("Setor 3"), value: "Setor 3"),
    DropdownMenuItem(child: Text("Setor 4"), value: "Setor 4"),
  ];
  return menuItems;
}
