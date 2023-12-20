import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thsyd/blocs/auth_bloc/auth_bloc.dart';
import 'package:thsyd/screens/main_view.dart';
import 'package:thsyd/screens/sign_in_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  static const routeName = "/authgate";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.status == AuthStateStatus.authenticated) {
        log(state.status.toString());
        Navigator.pushNamed(context, MainView.routeName);
      } else {
        log(state.status.toString());
        Navigator.pushNamed(context, SignInView.routeName);
      }
    }, builder: (context, state) {
      return WillPopScope(
          child: const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          onWillPop: () async => false);
    });
  }
}
