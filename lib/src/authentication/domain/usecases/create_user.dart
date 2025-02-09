import 'package:education_app/core/usecase/usercase.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;

  CreateUser(this._repository);

  @override
  ResultFuture<void> call(CreateUserParams params) async =>
      _repository.createUser(
        createAt: params.createAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String name;
  final String avatar;
  final String createAt;

  const CreateUserParams({
    required this.name,
    required this.avatar,
    required this.createAt,
  });

  const CreateUserParams.empty()
      : this(
          name: "_empty.name",
          avatar: "_empty.avatar",
          createAt: "_empty.createAt",
        );

  @override
  List<Object?> get props => [name, avatar, createAt];
}
