import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thsyd/repositories/auth_repository.dart';

part 'facebook_sign_in_state.dart';

class FacebookSignInCubit extends Cubit<FacebookSignInState> {
  final AuthRepository authRepository;
  final FirebaseFirestore firebaseFirestore;
  FacebookSignInCubit({
    required this.authRepository,
    required this.firebaseFirestore,
  }) : super(FacebookSignInState.initial());

  Future<void> signInWithFacebook() async {
    emit(
      state.copyWith(
        status: FacebookSignInStateStatus.submitted,
      ),
    );
    try {
      await authRepository.signInWithFacebook();

      emit(
        state.copyWith(
          status: FacebookSignInStateStatus.succeed,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: FacebookSignInStateStatus.error,
        ),
      );
    }
  }
}
