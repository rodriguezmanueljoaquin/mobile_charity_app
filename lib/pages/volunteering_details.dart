import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/ubication_card.dart';
import 'package:mobile_charity_app/design_system/organisms/modals/volunteering_modal.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/utils/availability_converter.dart';

class VolunteeringDetailsPage extends StatelessWidget {
  final VolunteeringModel volunteering;
  final String id;
  final bool isUserVolunteering;

  const VolunteeringDetailsPage({
    super.key,
    required this.volunteering,
    required this.id,
    this.isUserVolunteering = true,
  });

  Function _showDialog(
      {required BuildContext context, bool isEnlisting = true}) {
    return () => showDialog(
          context: context,
          builder: (BuildContext context) => SerManosVolunteeringModal(
            title: volunteering.title,
            isEnlisting: isEnlisting,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      applyPadding: false,
      whiteStatusBar: false,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 234,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: SerManosImages.full.image,
                              // image: NetworkImage(
                              //     'https://p6.storage.canalblog.com/69/50/922142/85510911_o.png'),
                              fit: BoxFit.cover),
                        ),
                        foregroundDecoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              SerManosColors.black,
                              SerManosColors.transparent
                            ],
                            stops: [0.0, 0.3555],
                          ),
                        ),
                      ),
                      Positioned(
                        top: SerManosSpacing.spaceMD,
                        left: SerManosSpacing.spaceMD,
                        child: SerManosIconButton(
                          icon: const SerManosIcon.back(
                              color: SerManosColors.neutral0),
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: SerManosSizes.sizeLG,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SerManosSizedBox.lg(),
                        SerManosText.overline(volunteering.category),
                        SerManosText.headline1(volunteering.title),
                        const SerManosSizedBox.sl(),
                        SerManosText.body1(
                          volunteering.description,
                          color: SerManosColors.secondary200,
                        ),
                        const SerManosSizedBox.md(),
                        SerManosText.headline2("Sobre la actividad"),
                        const SerManosSizedBox.sm(),
                        SerManosText.body1(volunteering.about),
                        const SerManosSizedBox.md(),
                        SerManosUbicationCard(address: volunteering.address),
                        const SerManosSizedBox.md(),
                        SerManosText.headline2("Participar del voluntariado"),
                        const SerManosSizedBox.sm(),
                        SerManosText.subtitle1("Requisitos"),
                        const SerManosSizedBox.sm(),
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: volunteering.requirements
                              .map((e) => SerManosText.body1('\u2022 $e'))
                              .toList(),
                        ),
                        const SerManosSizedBox.sm(),
                        SerManosText.subtitle1("Disponibilidad"),
                        const SerManosSizedBox.sm(),
                        ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: volunteering.availability
                              .map((e) => SerManosText.body1(
                                  '\u2022 ${availabilityToStr(e)}'))
                              .toList(),
                        ),
                        const SerManosSizedBox.sm(),
                        SerManosVacancies(
                          vacancies: volunteering.vacancies,
                        ),
                        const SerManosSizedBox.md(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isUserVolunteering
              ? SizedBox(
                  width: SerManosSizes.sizeLG,
                  child: Column(
                    children: [
                      const SerManosSizedBox.lg(),
                      SerManosText.headline2("Te has postulado"),
                      const SerManosSizedBox.sm(),
                      SerManosText.body1(
                          textAlign: TextAlign.center,
                          "Pronto la organización se pondrá en contacto contigo y te inscribirá como participante."),
                      const SerManosSizedBox.sm(),
                      SerManosTextButton.longTextButton(
                        text: 'Retirar postulación',
                        filled: false,
                        onPressed:
                            _showDialog(context: context, isEnlisting: false),
                        onLongPress:
                            _showDialog(context: context, isEnlisting: false),
                      ),
                      const SerManosSizedBox.xl(),
                    ],
                  ),
                )
              : Column(
                  children: [
                    SerManosTextButton.longTextButton(
                      text: 'Postularme',
                      onPressed: _showDialog(context: context),
                      onLongPress: _showDialog(context: context),
                    ),
                    const SerManosSizedBox.lg(),
                  ],
                ),
        ],
      ),
    );
  }
}
