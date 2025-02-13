import 'package:education_app/src/authentication/presentation/widgets/loading_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/authentication_cubit.dart';
import '../widgets/add_user_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) =>
                    AddUserDialog(nameController: nameController),
              );
            },
            icon: const Icon(Icons.add),
            label: Text('Add User'),
          ),
          body: state is GettingUsers
              ? const LoadingColumn(message: 'Fetching Users')
              : state is CreatingUser
                  ? const LoadingColumn(message: 'Creating User')
                  : state is UsersLoaded
                      ? Center(
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (context, index) {
                              final user = state.users[index];
                              return ListTile(
                                leading: Image.network(
                                  user.avatar,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                        'https://www.firstbenefits.org/wp-content/uploads/2017/10/placeholder-1024x1024.png');
                                  },
                                ),
                                title: Text(user.name),
                                subtitle: Text(user.createdAt.substring(10)),
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
        );
      },
    );
  }
}
