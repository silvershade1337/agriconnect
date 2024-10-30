part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthSuccessful extends AuthState {
  final String username;
  const AuthSuccessful(this.username);
}
