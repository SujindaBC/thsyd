import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'apple_sign_in_state.dart';

class AppleSignInCubit extends Cubit<AppleSignInState> {
  AppleSignInCubit() : super(AppleSignInState.initial());

  Future<void> signInWithApple() async {
    emit(
      state.copyWith(
        status: AppleSignInStateStatus.submitted,
      ),
    );
    try {
      emit(
        state.copyWith(
          status: AppleSignInStateStatus.succeed,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AppleSignInStateStatus.error,
        ),
      );
    }
  }
}
