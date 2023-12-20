import 'package:flutter/material.dart';
import 'package:patrimony/uikit/ui_ext.dart';

Widget googleButton({GestureTapCallback? onPress}) {
  return Card(
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
              Image.asset(
                'assets/icon/ic_google.png',
                height: 16,
              ),
              SizedBox(
                width: 1.5.widthPercent,
              ),
              Text(
                'Sign in with Google',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}