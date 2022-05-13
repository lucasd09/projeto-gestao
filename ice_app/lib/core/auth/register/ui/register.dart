// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ice_app/constants/app_constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var size, height, width;

  late double pad;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    pad = 16;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64.0),
        child: AppBar(
          backgroundColor: BackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: const Text(
            'Cadastro',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SizedBox(
            width: width/1.5,
            child: ListView(
              children: [
                const Center(child: Text('Dados da Empresa')),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                const Center(child: Text('Dados do Gerente')),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Placeholder',
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
