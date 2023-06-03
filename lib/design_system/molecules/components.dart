import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class Vacancies extends StatelessWidget {
  final int vacancies;
  const Vacancies({
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
            color: vacancies > 0 ?SerManosColors.secondary25 : SerManosColors.neutral25,
          ),
          padding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SerManosText.subtitle1("Vacantes: "),
              Row(
                children: [
                  SerManosIcon.person(enabled: vacancies > 0,),
                  SerManosText.subtitle1('$vacancies', color: vacancies > 0 ? SerManosColors.secondary200 : SerManosColors.secondary80),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}