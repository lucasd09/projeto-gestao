import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('ICE'),
          TextFormField(
            obscureText: false,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
              labelText: 'e-mail',
            ),
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: GestureDetector(
                  child: const Icon(Icons.visibility_off_outlined)),
              border: const OutlineInputBorder(),
              labelText: 'Senha',
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Login')),
          OutlinedButton(onPressed: () {}, child: const Text('Cadastre-se')),
        ],
      ),
    ));
  }
}
