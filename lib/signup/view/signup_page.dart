import 'package:atom_admin/gen/colors.gen.dart';
import 'package:atom_admin/packages/user_repository/user_repository.dart';
import 'package:atom_admin/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signup_view.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  static PageRoute<void> route() => PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
          create: (context) => SignupBloc(context.read<UserRepository>()),
          child: const SignupPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorName.XWhite,
      resizeToAvoidBottomInset: true,
      body: SignupView(),
    );
  }
}
