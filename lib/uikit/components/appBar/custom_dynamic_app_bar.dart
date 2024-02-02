import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_icon_button.dart';

class CustomDynamicAppBar extends StatelessWidget {
  final String title;

  const CustomDynamicAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 96,
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        children: [
          CustomIconButton(
            icon: Icons.arrow_back_ios,
            iconColor: Theme.of(context).primaryColorLight,
          ),
          const Spacer(),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.apply(
                  color: Theme.of(context).primaryColorLight,
                ),
          ),
          const Spacer(),
          CustomIconButton(
            icon: Icons.more_vert,
            iconColor: Theme.of(context).primaryColorLight,
          ),
        ],
      ),
    );
  }
}
