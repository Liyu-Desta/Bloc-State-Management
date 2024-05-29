import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:one/Application/bloc/loginbloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Logout'),
      content: Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Perform logout actions here
            print('saka kubba');
            context.read<AuthBloc>().add(EmptyAction());
            GoRouter.of(context).push('/login');
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
