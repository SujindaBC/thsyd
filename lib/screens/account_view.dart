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
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 28.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image.network(
                    context.read<AuthBloc>().state.user!.photoURL ?? ""),
              ),
            ),
          ),
        ),
        Text(
          context.read<AuthBloc>().state.user!.displayName ?? "",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4.0),
        FilledButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.black12,
            ),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Log out"),
                    content: Text(
                      "Do you want to log out?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(AuthRequestedSignoutEvent());
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
          label: const Text(
            "Sign out",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ));
  }
}
