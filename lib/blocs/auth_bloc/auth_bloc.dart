import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thsyd/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription authStreamSubscription;
  final AuthRepository authRepository;
  AuthBloc({
    required this.authRepository,
  }) : super(AuthState.unknown()) {
    authStreamSubscription = authRepository.user.listen((User? user) {
      add(AuthEventChanged(user: user));
    });
    on<AuthEventChanged>((event, emit) {
      emit(
        state.copyWith(
          status: event.user == null
              ? AuthStateStatus.unauthenticated
              : AuthStateStatus.authenticated,
          user: event.user,
        ),
      );
    });

    on<AuthRequestedSignoutEvent>((event, emit) async {
      await authRepository.signOut();
    });
  }

  @override
  Future<void> close() {
    authStreamSubscription.cancel();
    return super.close();
  }
}
