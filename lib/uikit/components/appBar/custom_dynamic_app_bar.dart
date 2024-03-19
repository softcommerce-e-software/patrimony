import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_icon_button.dart';

class MenuItem {
  String title;
  Function() onTap;

  MenuItem(this.title, this.onTap);
}

class CustomDynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasBackButton;
  final List<MenuItem> items;

  const CustomDynamicAppBar({
    super.key,
    required this.title,
    this.hasBackButton = true,
    required this.items,
  });

  void handleClick(String value) {
    items.firstWhere((element) =>
        element.title == value).onTap.call();
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
      actions: items.isNotEmpty ? [
        PopupMenuButton<String>(
          color: Theme.of(context).primaryColorLight,
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).primaryColorLight,
          ),
          onSelected: handleClick,
          itemBuilder: (BuildContext context) {
            return items.map((MenuItem choice) {
              return PopupMenuItem<String>(
                value: choice.title,
                child: Text(
                  choice.title,
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
