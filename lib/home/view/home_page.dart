import 'package:atom_admin/common/t_dialog.dart';
import 'package:atom_admin/gen/colors.gen.dart';
import 'package:atom_admin/home/home.dart';
import 'package:atom_admin/login/view/login_page.dart';
import 'package:atom_admin/packages/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static PageRoute<void> route({required String userId}) =>
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
          create: (context) =>
              HomeBloc(context.read<UserRepository>(), userId: userId),
          child: const HomePage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: ColorName.XWhite,
      appBar: AppBar(
        toolbarHeight: 72,
        centerTitle: true,
        title: Text(
          'Domain',
          style: textTheme.headlineSmall!.copyWith(color: ColorName.darkWhite),
        ),
        backgroundColor: ColorName.XRed,
        leading: IconButton(
          icon: const Icon(
            Icons.logout,
            color: ColorName.XWhite,
          ),
          onPressed: () => Navigator.of(context)
              .pushAndRemoveUntil(LoginPage.route(), (route) => false),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => showDialog<String?>(
                  context: context,
                  builder: (bContext) => const TDialog(),
                ).then((domain) {
                  if (domain != null && domain != '') {
                    context.read<HomeBloc>().add(SaveDomain(domain));
                  }
                }),
              ))
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: const HomeView(),
    );
  }
}
