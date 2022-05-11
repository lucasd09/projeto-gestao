// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ice_app/modules/dashboard/screens/dashboard_ui.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ICE',
                  style: TextStyle(
                    fontSize: 48,
                  )),
              TextFormField(
                obscureText: false,
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                  labelText: 'e-mail',
                ),
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outlined),
                  suffixIcon: GestureDetector(
                      child: const Icon(Icons.visibility_off_outlined)),
                  border: const OutlineInputBorder(),
                  labelText: 'Senha',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  child: const Text('Login')),
              OutlinedButton(
                  onPressed: () {}, child: const Text('Cadastre-se')),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
