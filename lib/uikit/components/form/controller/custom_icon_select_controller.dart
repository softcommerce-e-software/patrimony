import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:patrimony/uikit/mockup/icons_list.dart';

class CustomIconSelectController extends Store<bool> {
  CustomIconSelectController() : super(true);

  static CustomIconSelectController instance = CustomIconSelectController();

  int iconIndex = IconsList.flutterIcons.indexOf(IconsList.flutterIcons[0]);
  IconData icon = IconsList.flutterIcons[0];

  changeIcon(int index) {
    iconIndex = IconsList.flutterIcons.indexOf(IconsList.flutterIcons[index]);
    icon = IconsList.flutterIcons[iconIndex];
    return icon;
  }
}
