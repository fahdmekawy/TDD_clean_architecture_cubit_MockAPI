import 'package:education_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameController;

  const AddUserDialog({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  label: Text('Username'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  const avatar =
                      "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1212.jpg";
                  context.read<AuthenticationCubit>().createUser(
                        createdAt: DateTime.now().toString(),
                        name: name,
                        avatar: avatar,
                      );
                  Navigator.of(context).pop();
                },
                child: const Text('Create User'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
