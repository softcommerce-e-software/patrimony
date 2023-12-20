import 'package:flutter/material.dart';
import 'package:patrimony/uikit/ui_ext.dart';

class SimpleListScreen extends StatelessWidget {
  final Function(int index) onTap;
  final Function(int index)? onTapOptions;
  final List<String> labels;
  final String icon;
  const SimpleListScreen({
    super.key, required this.onTap, this.onTapOptions,
    required this.labels, required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
          itemCount: labels.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onTap(index),
              child: Card(
                child: SizedBox(
                  height: 9.heightPercent,
                  child: Row(
                    children: [
                      SizedBox(width: 2.widthPercent,),
                      Image.asset(
                        icon,
                        height: 5.heightPercent,
                      ),
                      SizedBox(width: 5.widthPercent,),
                      Text(
                        labels[index] ?? '',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      onTapOptions != null ?
                      GestureDetector(
                        onTap: () => onTapOptions!(index),
                        child: Image.asset(
                          'assets/icon/ic_option.webp',
                          height: 5.heightPercent,
                        ),
                      ) : const SizedBox(),
                      SizedBox(width: 2.widthPercent,),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
