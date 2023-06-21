import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/utils/logger.dart';

class SerManosEditPhotoCard extends StatefulWidget {
  final String? currentPhotoUrl;
  final Function(File?) onChange;

  const SerManosEditPhotoCard({
    super.key,
    this.currentPhotoUrl,
    required this.onChange,
  });

  @override
  State<SerManosEditPhotoCard> createState() => _SerManosEditPhotoCardState();
}

class _SerManosEditPhotoCardState extends State<SerManosEditPhotoCard> {
  Widget title = SerManosText.subtitle1("Foto de perfil");
  File? _image;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      widget.onChange(imageTemp);
      setState(() => _image = imageTemp);
    } on PlatformException catch (e) {
      logger.e('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? leftWidget, rightWidget;

    if (widget.currentPhotoUrl == null) {
      leftWidget = title;
      rightWidget = SerManosTextButton.shortTextButton(
          text: "Subir foto", onPressed: _pickImage);
    } else {
      leftWidget = Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title,
            const SerManosSizedBox.sm(),
            SerManosTextButton.shortTextButton(
              text: "Cambiar foto",
              onPressed: _pickImage,
            )
          ],
        ),
      );
      rightWidget = SerManosProfilePhoto(
        url: widget.currentPhotoUrl,
        image: _image,
        smallSize: true,
      );
    }

    return Container(
        width: 328,
        padding: const EdgeInsets.fromLTRB(16, 8, 19, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: SerManosColors.secondary25,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Expanded(child: leftWidget), rightWidget],
        ));
  }
}
