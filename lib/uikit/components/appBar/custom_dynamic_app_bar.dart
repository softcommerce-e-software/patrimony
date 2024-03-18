import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_icon_button.dart';

class CustomDynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasMenu;
  final bool hasBackButton;
  final Function? actionTap;

  const CustomDynamicAppBar({
    super.key,
    required this.title,
    this.actionTap,
    this.hasMenu = true,
    this.hasBackButton = true
  });

  void handleClick(String value) {
    switch (value) {
      case 'Apagar':
        actionTap?.call();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 96,
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      leading: hasBackButton ? CustomIconButton(
        icon: Icons.arrow_back_ios,
        iconColor: Theme.of(context).primaryColorLight,
        onPressed: () => Navigator.of(context).pop(),
      ) : null,
      actions: hasMenu ? [
        PopupMenuButton<String>(
          color: Theme.of(context).primaryColorLight,

          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).primaryColorLight,
          ),
          onSelected: handleClick,
          itemBuilder: (BuildContext context) {
            return {'Apagar'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(
                  choice,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error
                  ),
                ),
              );
            }).toList();
          },
        ),
      ] : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.apply(
          color: Theme.of(context).primaryColorLight,
        ),
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
