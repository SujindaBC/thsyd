// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.status,
    required this.user,
  });

  final AuthStateStatus status;
  final User? user;

  factory AuthState.unknown() {
    return const AuthState(
      status: AuthStateStatus.unknown,
      user: null,
    );
  }

  @override
  List<Object?> get props => [status, user];

  

  AuthState copyWith({
    AuthStateStatus? status,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}

enum AuthStateStatus {
  unauthenticated,
  authenticated,
  unknown,
}
