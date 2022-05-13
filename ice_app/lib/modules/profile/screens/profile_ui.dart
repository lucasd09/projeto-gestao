import 'package:flutter/material.dart';
import 'package:ice_app/core/auth/login/models/auth_service.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(),
        Row(
          
          children: const [
            Text('Nome Sobrenome'),
            Text('Empresa'),
            Text('Cargo'),
            Text('e-mail')
          ],
        ),
        TextButton.icon(
          onPressed: () {
            context.read<AuthService>().signOut();
          },
          icon: const Icon(Icons.logout_outlined),
          label: const Text('Logout'),
        )
      ],
    ));
  }
}
