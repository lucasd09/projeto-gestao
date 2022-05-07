// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ice_app/modules/dashboard/screens/dashboard_ui.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  var size,height,width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        body: SizedBox(
          width: width/2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ICE',
                style: TextStyle(
                  fontSize: 48,
                )),
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
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const Dashboard());
                },
                child: const Text('Login')),
            OutlinedButton(onPressed: () {}, child: const Text('Cadastre-se')),
          ],
        ),
      ),
    )
  );
  }
}
