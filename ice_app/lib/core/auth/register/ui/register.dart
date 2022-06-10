// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ice_app/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../login/models/auth_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final razaoController = TextEditingController();
  final fantasiaController = TextEditingController();
  final ieController = TextEditingController();
  final cnpjController = TextEditingController();

  final nomeController = TextEditingController();
  final jobController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final senha2Controller = TextEditingController();

  var size, height, width;

  late double pad;

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final Stream<QuerySnapshot> companies =
        FirebaseFirestore.instance.collection("companies").snapshots();

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
            width: width / 1.2,
            child: ListView(
              children: [
                const Center(child: Text('Dados da Empresa')),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      controller: razaoController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Razão Social',
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      controller: fantasiaController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome Fantasia',
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      controller: ieController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'IE',
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      controller: cnpjController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CNPJ',
                      )),
                ),
                const Center(child: Text('Dados do Gerente')),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      controller: jobController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cargo',
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'email',
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      controller: senhaController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: pad),
                  child: TextFormField(
                      controller: senha2Controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Repetir senha',
                      )),
                ),
                StreamBuilder(
                    stream: companies,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('ERRO');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final data = snapshot.requireData;

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: PrimaryColor,
                            fixedSize: const Size(155, 40)),
                        onPressed: () {
                          if (senhaController.text == senha2Controller.text) {
                            var user = <String, dynamic>{
                              "name": nomeController.text.trim(),
                              "company": fantasiaController.text.trim(),
                              "job": jobController.text.trim(),
                              "email": emailController.text.trim()
                            };

                            var empresa = <String, dynamic>{
                              "razaosocial": razaoController.text.trim(),
                              "nomefantasia": fantasiaController.text.trim(),
                              "cnpj": cnpjController.text.trim(),
                              "ie": ieController.text.trim()
                            };

                            db
                                .collection("users")
                                .doc(emailController.text.trim())
                                .set(user);
                            db
                                .collection("companies")
                                .doc((data.size + 1).toString())
                                .set(empresa);

                            context.read<AuthService>().signUp(
                                email: emailController.text.trim(),
                                password: senhaController.text);

                            razaoController.clear();
                            fantasiaController.clear();
                            cnpjController.clear();
                            ieController.clear();
                            nomeController.clear();
                            senhaController.clear();
                            senha2Controller.clear();
                            emailController.clear();
                            jobController.clear();

                            Navigator.pop(context);

                            final snackBar = SnackBar(
                              content:
                                  const Text('Cadastro realizado com Sucesso!'),
                              action: SnackBarAction(
                                label: 'Fechar',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text('Cadastrar'),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
