import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:patrimony/uikit/components/listview/custom_list_item.dart';
import 'package:patrimony/uikit/components/listview/custom_list_view_header.dart';

class CustomListView extends StatefulWidget {
  final int itemCount;
  final CustomListItem child;

  const CustomListView({
    super.key,
    required this.itemCount,
    required this.child,
  });

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  SlidableController slidableController = SlidableController();

  final double _defaultPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        top: _defaultPadding,
        left: _defaultPadding,
        right: _defaultPadding,
        bottom: (widget.itemCount > 0) ? _defaultPadding : 0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomListViewHeader(
            title: 'Algum titulo',
            prefixIcon: true,
            icon: Icons.access_alarm_outlined,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Theme.of(context).dividerColor,
            margin: const EdgeInsets.only(top: 8),
          ),
          Flexible(
            child: ListView.separated(
              itemCount: widget.itemCount,
              separatorBuilder: (_, __) => const Divider(height: 0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Slidable(
                  controller: slidableController,
                  actionPane: const SlidableStrechActionPane(),
                  secondaryActions: [
                    const SizedBox(width: 8),
                    IconSlideAction(
                      color: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      icon: Icons.edit,
                    ),
                    IconSlideAction(
                      color: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).primaryColorLight,
                      icon: Icons.delete,
                    ),
                  ],
                  child: widget.child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
