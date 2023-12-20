// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'facebook_sign_in_cubit.dart';

class FacebookSignInState extends Equatable {
  const FacebookSignInState({
    required this.status,
  });

  final FacebookSignInStateStatus status;

  @override
  List<Object> get props => [status];

  factory FacebookSignInState.initial() {
    return const FacebookSignInState(
      status: FacebookSignInStateStatus.initial,
    );
  }

  FacebookSignInState copyWith({
    FacebookSignInStateStatus? status,
  }) {
    return FacebookSignInState(
      status: status ?? this.status,
    );
  }
}

enum FacebookSignInStateStatus {
  initial,
  submitted,
  succeed,
  error,
}
