part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

class UsersLoaded extends AuthenticationState {
  final List<User> users;

  const UsersLoaded(this.users);

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}
