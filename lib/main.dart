import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_note_app/views/login_view.dart';
import 'package:my_note_app/views/register_view.dart';
import 'package:my_note_app/views/verify_email_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const Text('Email is verified');
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            // final emailVerified = user?.emailVerified ?? false;
            // if (emailVerified) {
            //   return const Text('Done');
            // } else {
            //   return const VerifyEmailView();
            // }

            default:
              return const Text('Loading...');
          }
        });
  }
}
