import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thsyd/repositories/auth_repository.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  final AuthRepository authRepository;
  GoogleSignInCubit({
    required this.authRepository,
  }) : super(GoogleSignInState.initial());

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: GoogleSignInStateStatus.submitted));
    try {
      await authRepository.signInWithGoogle();
      emit(state.copyWith(status: GoogleSignInStateStatus.succeed));
    } catch (error) {
      emit(state.copyWith(status: GoogleSignInStateStatus.error));
    }
  }
}
