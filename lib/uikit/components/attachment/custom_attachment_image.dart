import 'dart:io';
import 'package:flutter/material.dart';

class CustomAttachmentImage extends StatelessWidget {
  final String? image;
  final VoidCallback? onTap;
  final String name;

  const CustomAttachmentImage({
    super.key,
    this.image,
    this.onTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      height: 164,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.delete_forever_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              child: image != null ? Image.file(File(image!)) : null,
            ),
          ),
        ],
      ),
    );
  }
}
