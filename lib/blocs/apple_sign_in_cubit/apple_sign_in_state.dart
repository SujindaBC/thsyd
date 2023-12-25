// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'apple_sign_in_cubit.dart';

class AppleSignInState extends Equatable {
  const AppleSignInState({
    required this.status,
  });

  final AppleSignInStateStatus status;

  @override
  List<Object> get props => [status];

  factory AppleSignInState.initial() {
    return const AppleSignInState(
      status: AppleSignInStateStatus.initial,
    );
  }

  AppleSignInState copyWith({
    AppleSignInStateStatus? status,
  }) {
    return AppleSignInState(
      status: status ?? this.status,
    );
  }
}

enum AppleSignInStateStatus {
  initial,
  submitted,
  succeed,
  error,
}
