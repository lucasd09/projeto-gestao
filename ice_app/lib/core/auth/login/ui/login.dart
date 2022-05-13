// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable
import 'package:flutter/material.dart';
import 'package:ice_app/core/auth/login/models/auth_service.dart';
import 'package:ice_app/core/auth/register/ui/register.dart';
import 'package:provider/provider.dart';

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
          width: width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 78),
                  child: Image.asset('assets/images/ice_logo.png')),
              Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: TextFormField(
                  obscureText: false,
                  controller: emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'e-mail',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 51),
                child: TextFormField(
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
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthService>().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim());
                  },
                  child: const Text('Login')),
              OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                  child: const Text('Cadastre-se')),
            ],
          ),
        ),
      ),
    );
  }
}
