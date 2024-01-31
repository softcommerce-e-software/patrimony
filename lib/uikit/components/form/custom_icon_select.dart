import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/buttons/custom_icon_button.dart';
import 'package:patrimony/uikit/components/form/controller/custom_icon_select_controller.dart';
import 'package:patrimony/uikit/components/gridview/custom_grid_icon_item.dart';
import 'package:patrimony/uikit/mockup/icons_list.dart';

class CustomIconSelect extends StatefulWidget {
  final VoidCallback? closePressed;

  const CustomIconSelect({super.key, this.closePressed});

  @override
  State<CustomIconSelect> createState() => _CustomIconSelectState();
}

class _CustomIconSelectState extends State<CustomIconSelect> {
  final _defaultBorder = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: _defaultBorder,
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: _defaultBorder,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Icones',
                    style: Theme.of(context).textTheme.displayLarge?.apply(
                          color: Theme.of(context).primaryColorDark,
                        ),
                  ),
                  const Spacer(),
                  CustomIconButton(
                    icon: Icons.close,
                    iconColor: Theme.of(context).primaryColorDark,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Flexible(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    if (index < IconsList.flutterIcons.length) {
                      return GridTile(
                        child: CustomGridIconItem(
                          onTap: () {
                            CustomIconSelectController.instance
                                .changeIcon(index);
                            Navigator.pop(context);
                          },
                          icon: IconsList.flutterIcons[index],
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
