import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class CustomSignInScreen extends StatelessWidget {
  const CustomSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomEmailSignInForm();
  }
}

class CustomEmailSignInForm extends StatelessWidget {
  CustomEmailSignInForm({Key? key}) : super(key: key);

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthFlowBuilder<EmailFlowController>(
          builder: (context, state, controller, _) {
        if (state is AwaitingEmailAndPassword) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailCtrl,
              ),
              TextField(
                controller: passwordCtrl,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.setEmailAndPassword(
                      emailCtrl.text,
                      passwordCtrl.text,
                    );
                  },
                  child: const Text('Sign in')),
            ],
          );
        } else if (state is SigningIn) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthFailed) {
          return ErrorText(exception: state.exception);
        }
        return Center(
          child: Text('??'),
        );
      }),
    );
  }
}
