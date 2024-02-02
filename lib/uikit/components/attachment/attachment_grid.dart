import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patrimony/uikit/components/attachment/custom_attachment_image.dart';

class AttachmentGrid extends StatefulWidget {
  const AttachmentGrid({super.key});

  @override
  State<AttachmentGrid> createState() => _AttachmentGridState();
}

class _AttachmentGridState extends State<AttachmentGrid> {
  final List<String> _attachments = [];

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
            GestureDetector(
              onTap: () {
                addAttachment();
              },
              child: Text(
                'adicionar',
                style: Theme.of(context).textTheme.bodyMedium?.apply(
                      color: Theme.of(context).primaryColorDark,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 162,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _attachments.length,
            itemBuilder: (context, index) {
              return CustomAttachmentImage(
                name: 'Anexo ${index + 1}',
                image: _attachments[index],
                onTap: () {
                  setState(() {
                    _attachments.removeAt(index);
                  });
                },
              );
            },
          ),
        )
      ],
    );
  }

  addAttachment() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null &&
          _attachments.length < 3 &&
          _attachments
              .singleWhere((element) => element.split('/').last == file.name,
                  orElse: () => '')
              .isEmpty) {
        setState(() {
          _attachments.add(file.path);
        });
      }
    } catch (e) {
      throw Error();
    }
  }
}
