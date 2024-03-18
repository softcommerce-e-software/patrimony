import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patrimony/uikit/components/attachment/custom_attachment_image.dart';

class AttachmentEntity {
  String id;
  String url;

  AttachmentEntity(this.id, this.url);
}

class AttachmentGrid extends StatefulWidget {
  final VoidCallback? onAdd;
  final Function(AttachmentEntity value)? onDelete;
  final List<AttachmentEntity> items;
  const AttachmentGrid({
    super.key,
    this.onDelete,
    required this.items,
    this.onAdd
  });

  @override
  State<AttachmentGrid> createState() => _AttachmentGridState();
}

class _AttachmentGridState extends State<AttachmentGrid> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Faturas em anexo',
              style: Theme.of(context).textTheme.displaySmall?.apply(
                    color: Theme.of(context).primaryColorDark,
                  ),
            ),
            const Spacer(),
            InkWell(
              onTap: widget.items.length < 3 ? widget.onAdd : null,
              child: Text(
                'adicionar',
                style: Theme.of(context).textTheme.bodyMedium?.apply(
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 162,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return CustomAttachmentImage(
                name: 'Anexo ${index + 1}',
                image: widget.items[index].url,
                onTap: () => widget.onDelete?.call(widget.items[index]),
              );
            },
          ),
        )
      ],
    );
  }
}

Future<File?> addAttachment() async {
  final ImagePicker picker = ImagePicker();
  try {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return File(file.path);
    } else {
      return null;
    }
  } catch (e) {
    throw Error();
  }
}
