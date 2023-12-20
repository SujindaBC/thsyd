part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthEventChanged extends AuthEvent {
  const AuthEventChanged({
    required this.user,
  });

  final User? user;

  @override
  List<Object?> get props => [user];
}

class AuthRequestedSignoutEvent extends AuthEvent {}
