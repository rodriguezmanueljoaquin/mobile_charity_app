import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosProfilePhoto extends StatelessWidget {
  final bool smallSize;
  final String? url;
  final File? image;

  const SerManosProfilePhoto({
    super.key,
    this.smallSize = false,
    this.url,
    this.image,
  });

  ImageProvider? _getImage() {
    if (image != null) {
      return FileImage(image!);
    } else if (url != null) {
      return NetworkImage(url!);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = smallSize ? 84 : 110;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: SerManosColors.neutral0,
        backgroundImage: _getImage(),
        child: url != null ? null : SerManosImages.profileDefaultPhoto,
      ),
    );
  }
}

class SerManosVacancies extends StatelessWidget {
  final int vacancies;
  const SerManosVacancies({
    super.key,
    this.vacancies = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: vacancies > 0
                ? SerManosColors.secondary25
                : SerManosColors.neutral25,
          ),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SerManosText.subtitle1("Vacantes: "),
              Row(
                children: [
                  SerManosIcon.person(
                    enabled: vacancies > 0,
                  ),
                  SerManosText.subtitle1('$vacancies',
                      color: vacancies > 0
                          ? SerManosColors.secondary200
                          : SerManosColors.secondary80),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
