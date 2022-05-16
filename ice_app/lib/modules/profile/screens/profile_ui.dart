// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ice_app/constants/app_constants.dart';
import 'package:ice_app/core/auth/login/models/auth_service.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var size, height, width;
  
  bool enable = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Center(
        child: SizedBox(
      width: width / 1.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset('assets/images/ice_logo.png', width: 160, height: 160,),
              ElevatedButton(
                  onPressed: () { enable = !enable;},
                  child: const Icon(Icons.drive_file_rename_outline_outlined))
            ],
          ),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Nome Sobrenome'),
            enabled: enable,
          ),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Empresa'),
            enabled: enable,
          ),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'Cargo'),
            enabled: enable,
          ),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'e-mail'),
            enabled: enable,
          ),
          TextButton.icon(
            onPressed: () {
              context.read<AuthService>().signOut();
            },
            icon: const Icon(Icons.logout_outlined),
            label: const Text(
              'Logout',
              style: TextStyle(color: PrimaryTextColor),
            ),
          )
        ],
      ),
    ));
  }
}
