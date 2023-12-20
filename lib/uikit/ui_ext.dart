import 'dart:ui';

extension UiExt on num {
  Size get _size => (window.physicalSize / window.devicePixelRatio);

  double get heightPercent => (this / 100.0) * _size.height;
  double get widthPercent => (this / 100.0) * _size.width;
}