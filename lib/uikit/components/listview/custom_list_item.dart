import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String sufixTitle;
  final String sufixSubtitle;
  final IconData? icon;

  const CustomListItem({
    super.key,
    this.icon,
    this.subtitle = '',
    this.sufixTitle = '',
    this.sufixSubtitle = '',
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: icon != null
            ? Icon(
                icon,
                color: Theme.of(context).primaryColorDark,
                size: 30,
              )
            : null,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.apply(
                    color: Theme.of(context).primaryColorDark,
                  ),
            ),
            subtitle != ''
                ? Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: Theme.of(context).disabledColor,
                        ),
                  )
                : const SizedBox(),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sufixTitle != ''
                ? Text(
                    sufixTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.apply(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  )
                : const SizedBox(),
            sufixSubtitle != ''
                ? Text(
                    sufixSubtitle,
                    style: Theme.of(context).textTheme.labelMedium?.apply(
                          color: Theme.of(context).disabledColor,
                        ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
