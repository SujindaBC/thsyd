import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:thsyd/blocs/facebook_sign_in_cubit/facebook_sign_in_cubit.dart';
import 'package:thsyd/blocs/google_sign_in_cubit/google_sign_in_cubit.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  static const routeName = "/signin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32),
              SignInButton(
                Buttons.googleDark,
                onPressed: () {
                  context.read<GoogleSignInCubit>().signInWithGoogle();
                },
              ),
              SignInButton(
                Buttons.apple,
                onPressed: () {},
              ),
              const Text("or"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(
                    Buttons.facebook,
                    mini: true,
                    onPressed: () {
                      context.read<FacebookSignInCubit>().signInWithFacebook();
                    },
                  ),
                  SignInButton(
                    Buttons.twitter,
                    mini: true,
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
