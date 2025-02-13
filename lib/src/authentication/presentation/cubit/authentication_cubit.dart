import 'package:bloc/bloc.dart';
import 'package:education_app/src/authentication/domain/usecases/create_user.dart';
import 'package:education_app/src/authentication/domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CreateUser _createUser;
  final GetUsers _getUsers;

  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(AuthenticationInitial());

  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(CreatingUser());
    final result = await _createUser.call(
        CreateUserParams(name: name, avatar: avatar, createAt: createdAt));

    result.fold(
      (failure) => emit(
        AuthenticationError(failure.errorMessage),
      ),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> getUsers() async {
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
