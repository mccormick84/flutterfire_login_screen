import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:login_screen/screen/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is not signed in
          if (!snapshot.hasData) {
            return SignInScreen(
              headerBuilder: (context, constraints, _) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      'https://firebase.flutter.dev/img/flutterfire_300x.png',
                    ),
                  ),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'Welcome to FlutterFire UI! Please sign in to continue.'
                        : 'Welcome to FlutterFire UI! Please create an account to continue.',
                  ),
                );
              },
              footerBuilder: (context, _) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'By signing in you agree to our terms and conditions.',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              },
              providerConfigs: [
                GoogleProviderConfiguration(
                  clientId:
                      '560695154144-41jcdbfrhm87obg3inkr94phe9fhl7qk.apps.googleusercontent.com',
                ),
                EmailProviderConfiguration(),
              ],
            );
          }
          return HomeScreen();
        },
    );
  }
}
