import 'package:flutter/material.dart';
import 'package:ice_app/core/auth/login/models/auth_service.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              child: const Text('Logout Dashboard')),
    );
  }
}