import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosEditPhotoCard extends StatefulWidget {
  final String? currentPhotoUrl;

  const SerManosEditPhotoCard({
    super.key,
    this.currentPhotoUrl,
  });

  @override
  State<SerManosEditPhotoCard> createState() => _SerManosEditPhotoCardState();
}

class _SerManosEditPhotoCardState extends State<SerManosEditPhotoCard> {
  Widget title = SerManosText.subtitle1("Foto de perfil");

  @override
  Widget build(BuildContext context) {
    Widget? leftWidget, rightWidget;

    if (widget.currentPhotoUrl == null) {
      leftWidget = title;
      rightWidget = SerManosTextButton.shortTextButton(
          text: "Subir foto", small: true, onPressed: () {});
    } else {
      leftWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          const SerManosSizedBox.sm(),
          SerManosTextButton.shortTextButton(
              text: "Cambiar foto", small: true, onPressed: () {})
        ],
      );
      rightWidget = SerManosProfilePhoto(
        url: widget.currentPhotoUrl,
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
