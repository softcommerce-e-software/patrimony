import 'package:flutter/material.dart';
import 'package:patrimony/uikit/ui_ext.dart';

Widget appleButton({GestureTapCallback? onPress}) {
  return Card(
    color: Colors.black,
    elevation: 8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    child: InkWell(
      onTap: onPress,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        height: 5.5.heightPercent,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 1.heightPercent,
            horizontal: 2.widthPercent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.apple,
                color: Colors.white,
              ),
              SizedBox(
                width: 1.widthPercent,
              ),
              const Text(
                'Sign in with Apple',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}