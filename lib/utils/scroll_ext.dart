import 'package:flutter/cupertino.dart';

extension ScrollExt on ScrollController {
  void onFinalScroll({required Function call}) {
    addListener(() {
      if(position.pixels + 100
          >= position.maxScrollExtent
      ) {
          call.call();
      }
    });
  }
}