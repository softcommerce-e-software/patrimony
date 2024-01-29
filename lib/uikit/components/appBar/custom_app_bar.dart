import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_icon_button.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final String username = 'Nome de um usuário aqui';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 96,
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight.withOpacity(.50),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                username.length > 16
                    ? '${username.substring(0, 16)}...'
                    : username,
                style: Theme.of(context).textTheme.titleLarge?.apply(
                      color: Theme.of(context).primaryColorLight,
                    ),
              ),
            ],
          ),
          const Spacer(),
          CustomIconButton(
            icon: Icons.notifications_outlined,
            iconColor: Theme.of(context).primaryColorLight,
          ),
          const SizedBox(width: 4),
          CustomIconButton(
            icon: Icons.more_vert,
            iconColor: Theme.of(context).primaryColorLight,
          ),
        ],
      ),
    );
  }
}
