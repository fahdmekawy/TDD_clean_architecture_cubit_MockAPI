import 'package:education_app/src/authentication/domain/usecases/get_users.dart';
import 'package:education_app/src/authentication/domain/usecases/create_user.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;

  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUsersEvent>(_getUsersHandler);
  }

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(CreatingUser());
    final result = await _createUser.call(CreateUserParams(
        name: event.name, avatar: event.avatar, createAt: event.createdAt));

    result.fold(
      (failure) => emit(
        AuthenticationError(failure.errorMessage),
      ),
      (_) => emit(const UserCreated()),
    );
  }

  void _getUsersHandler(
      GetUsersEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GettingUsers());

    final result = await _getUsers();
    result.fold(
      (failure) => emit(
        AuthenticationError(failure.errorMessage),
      ),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
