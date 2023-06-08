import 'package:atom_admin/common/t_element.dart';
import 'package:atom_admin/gen/colors.gen.dart';
import 'package:atom_admin/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final domainStream = context.read<HomeBloc>().domain;

    return StreamBuilder(
      stream: domainStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data as List<dynamic>;
        return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (_, __) => Divider(
                  color: ColorName.XBlack.withAlpha(106),
                  thickness: 1.2,
                ),
            itemBuilder: (_, index) {
              final item = data[index];
              return TElement(
                title: item['name'],
                // subtitle: item['password'],
                subtitle: '',
                iconData: Icons.campaign_outlined,
                onPressed: () {},
                isAdmin: true,
                onDeletePressed: () =>
                    context.read<HomeBloc>().add(DeleteDomain(item['id'])),
              );
            });
        // Return your widget with the data from the snapshot
      },
    );
  }
}
