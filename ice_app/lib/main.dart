import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ice_app/constants/app_constants.dart';
import 'package:ice_app/core/auth/login/models/auth_service.dart';
import 'package:ice_app/core/auth/login/ui/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ice_app/widgets/app_wrapper.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges, initialData: null,
          )
        ],
        child: MaterialApp(
          title: 'Ice App',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: PrimaryColor,
            scaffoldBackgroundColor: BackgroundColor,
          ),
          home: const AuthWrapper(),
        ));
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const AppWrapper();
    }
    return const Login();
  }
}
