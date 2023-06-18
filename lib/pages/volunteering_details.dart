import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
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
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:mobile_charity_app/utils/availability_converter.dart';
import 'package:provider/provider.dart';

class VolunteeringDetailsPage extends StatelessWidget {
  final String id;

  const VolunteeringDetailsPage({
    super.key,
    required this.id,
  });

  final String cancelTitle = '¿Estás seguro que querés retirar tu postulación?';

  final String enlistTitle = 'Te estás por postular a';

  final String abandonTitle =
      '¿Estás seguro que querés abandonar tu voluntariado?';

  Function _showDialog({
    required BuildContext context,
    required String dialogTitle,
    required VolunteeringModel volunteering,
    required Function onConfirm,
  }) {
    return () => showDialog(
          context: context,
          builder: (BuildContext context) => SerManosVolunteeringModal(
            title: dialogTitle,
            volunteering: volunteering,
            onConfirm: onConfirm,
          ),
        );
  }

  Function _showApplyDialog(
          {required BuildContext context,
          required VolunteeringModel volunteering}) =>
      _showDialog(
        context: context,
        dialogTitle: enlistTitle,
        volunteering: volunteering,
        onConfirm: () =>
            Provider.of<VolunteeringProvider>(context, listen: false)
                .applyToVolunteering(id),
      );

  Function _showAbandonDialog(
          {required BuildContext context,
          required VolunteeringModel volunteering}) =>
      _showDialog(
        context: context,
        dialogTitle: abandonTitle,
        volunteering: volunteering,
        onConfirm: Provider.of<VolunteeringProvider>(context, listen: false)
            .abandonCurrentVolunteering,
      );

  Function _showCancelDialog(
          {required BuildContext context,
          required VolunteeringModel volunteering}) =>
      _showDialog(
        context: context,
        dialogTitle: cancelTitle,
        volunteering: volunteering,
        onConfirm: Provider.of<VolunteeringProvider>(context, listen: false)
            .abandonCurrentVolunteering,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer2<VolunteeringProvider, UserProvider>(
      builder: (context, volunteeringProvider, userProvider, child) {
        if (volunteeringProvider.isFetchingVolunteerings) {
          return const CircularProgressIndicator();
        }

        VolunteeringModel volunteering =
            volunteeringProvider.getVolunteeringById(id)!;

        UserModel user = userProvider.user!;
        bool userIsAlreadyVolunteer =
            user.currentVolunteeringId == volunteering.id;

        return SerManosScaffold(
          applyPadding: false,
          whiteStatusBar: false,
          body: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => volunteeringProvider
                      .fetchVolunteeringById(id)
                      .then((_) => userProvider.fetchUser()),
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
                                    image: NetworkImage(volunteering.imageURL),
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
                              SerManosUbicationCard(
                                  address: volunteering.address),
                              const SerManosSizedBox.md(),
                              SerManosText.headline2(
                                  "Participar del voluntariado"),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SerManosSizedBox.md(),
              SizedBox(
                width: SerManosSizes.sizeLG,
                child: userIsAlreadyVolunteer
                    ? Column(
                        children: [
                          SerManosText.headline2("Te has postulado"),
                          const SerManosSizedBox.sm(),
                          SerManosText.body1(
                              textAlign: TextAlign.center,
                              "Pronto la organización se pondrá en contacto contigo y te inscribirá como participante."),
                          const SerManosSizedBox.sm(),
                          SerManosTextButton.longTextButton(
                            text: 'Retirar postulación',
                            filled: false,
                            onPressed: _showCancelDialog(
                                context: context, volunteering: volunteering),
                          ),
                          const SerManosSizedBox.md(),
                        ],
                      )
                    : Column(
                        children: [
                          if (user.currentVolunteeringId != null)
                            Column(
                              children: [
                                const SerManosSizedBox.md(),
                                SerManosText.body1(
                                    textAlign: TextAlign.center,
                                    "Ya estas participando en otro voluntariado, debes abandonarlo primero para postularte a este."),
                                const SerManosSizedBox.sm(),
                                SerManosTextButton.longTextButton(
                                  text: 'Abandonar voluntariado actual',
                                  filled: false,
                                  onPressed: _showAbandonDialog(
                                      context: context,
                                      volunteering: volunteering),
                                ),
                                const SerManosSizedBox.md(),
                              ],
                            ),
                          SerManosTextButton.longTextButton(
                            text: 'Postularme',
                            disabled: volunteering.vacancies == 0,
                            onPressed: _showApplyDialog(
                                context: context, volunteering: volunteering),
                          ),
                        ],
                      ),
              ),
              const SerManosSizedBox.lg(),
            ],
          ),
        );
      },
    );
  }
}
