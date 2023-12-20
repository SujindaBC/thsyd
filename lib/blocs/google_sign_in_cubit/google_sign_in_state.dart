// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'google_sign_in_cubit.dart';

class GoogleSignInState extends Equatable {
  const GoogleSignInState({
    required this.status,
  });

  final GoogleSignInStateStatus status;

  @override
  List<Object> get props => [status];

  factory GoogleSignInState.initial() {
    return const GoogleSignInState(
      status: GoogleSignInStateStatus.initial,
    );
  }

  GoogleSignInState copyWith({
    GoogleSignInStateStatus? status,
  }) {
    return GoogleSignInState(
      status: status ?? this.status,
    );
  }
}

enum GoogleSignInStateStatus {
  initial,
  submitted,
  succeed,
  error,
}
