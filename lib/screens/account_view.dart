import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thsyd/blocs/auth_bloc/auth_bloc.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  static const routeName = "/profileview";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Text(context.read<AuthBloc>().state.user!.uid),
        Text(
          context.read<AuthBloc>().state.user!.metadata.creationTime.toString(),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthRequestedSignoutEvent());
          },
          child: const Text("Sign out"),
        ),
      ],
    ));
  }
}
