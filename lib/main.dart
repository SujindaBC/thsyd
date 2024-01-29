import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thsyd/blocs/auth_bloc/auth_bloc.dart';
import 'package:thsyd/blocs/facebook_sign_in_cubit/facebook_sign_in_cubit.dart';
import 'package:thsyd/blocs/google_sign_in_cubit/google_sign_in_cubit.dart';
import 'package:thsyd/firebase_options.dart';
import 'package:thsyd/repositories/auth_repository.dart';
import 'package:thsyd/screens/account_view.dart';
import 'package:thsyd/screens/auth_gate.dart';
import 'package:thsyd/screens/create_post.dart';
import 'package:thsyd/screens/home_view.dart';
import 'package:thsyd/screens/housemate.dart';
import 'package:thsyd/screens/jobhub.dart';
import 'package:thsyd/screens/main_view.dart';
import 'package:thsyd/screens/sign_in_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseAuth: FirebaseAuth.instance,
              firebaseFirestore: FirebaseFirestore.instance,
              googleSignIn: GoogleSignIn(scopes: ["email"])),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => GoogleSignInCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => FacebookSignInCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: "THSYD",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: AuthGate.routeName,
          routes: {
            AuthGate.routeName: (context) => const AuthGate(),
            AccountView.routeName: (context) => const AccountView(),
            SignInView.routeName: (context) => const SignInView(),
            MainView.routeName: (context) => const MainView(),
            HomeView.routeName: (context) => const HomeView(),
            CreatePost.routeName: (context) => const CreatePost(),
            JobHub.routeName: (context) => const JobHub(),
            HouseMate.routeName: (context) => const HouseMate(),
          },
        ),
      ),
    );
  }
}
