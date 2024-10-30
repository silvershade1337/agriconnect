part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {

}

class AuthSuccess extends AuthEvent {
  final String username;
  AuthSuccess(this.username);
}
