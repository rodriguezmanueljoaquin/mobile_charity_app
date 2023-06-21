import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/information_card.dart';
import 'package:mobile_charity_app/design_system/organisms/modals/volunteering_modal.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/routes/paths.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    super.key,
  });

  Function _onLogout({required BuildContext context}) {
    return () => showDialog(
          context: context,
          builder: (BuildContext context) => SerManosVolunteeringModal(
              title: "¿Estás seguro que quieres cerrar sesión?",
              acceptText: "Cerrar sesión",
              onConfirm: () async {
                return await Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).logout().then(
                      (_) => context.replaceNamed(SerManosPagesName.signin),
                    );
              }),
        );
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserProvider>(context).user!;
    final bool completed = user.hasCompleteProfile;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SerManosSizedBox.lg(),
                  Center(
                    child: SerManosProfilePhoto(url: user.downloadAvatarURL),
                  ),
                  const SerManosSizedBox.sl(),
                  SerManosText.overline("VOLUNTARIO"),
                  const SerManosSizedBox.sm(),
                  SerManosText.subtitle1(
                    user.fullName,
                    textAlign: TextAlign.center,
                  ),
                  const SerManosSizedBox.sm(),
                  if (completed) ...[
                    SerManosText.body1(
                      user.email!,
                      color: SerManosColors.secondary200,
                      textAlign: TextAlign.center,
                    ),
                    const SerManosSizedBox.lg(),
                    ProfileData(user: user),
                  ] else
                    SerManosText.body1(
                      "¡Completá tu perfil para tener acceso a mejores oportunidades!",
                      textAlign: TextAlign.center,
                    ),
                  Visibility(
                      visible: completed,
                      child: Column(
                        children: [
                          SerManosTextButton.longTextButton(
                            text: "Editar perfil",
                            onPressed: () {
                              context.pushNamed(SerManosPagesName.profileEdit);
                            },
                          ),
                          const SerManosSizedBox.sm(),
                          SerManosTextButton.longTextButton(
                            text: "Cerrar sesión",
                            onPressed: _onLogout(context: context),
                            filled: false,
                            textColor: SerManosColors.error100,
                          ),
                          const SerManosSizedBox.xl(),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: !completed,
          child: Column(
            children: [
              SerManosTextButton.shortTextButton(
                text: "Completar",
                icon: const SerManosIcon.add(),
                onPressed: () {
                  context.pushNamed(SerManosPagesName.profileEdit);
                },
              ),
              const SerManosSizedBox.xl(),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileData extends StatelessWidget {
  final UserModel user;

  const ProfileData({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SerManosInformationCard(
          title: "Información personal",
          contentsByLabel: Map.from({
            "Fecha de nacimiento":
                DateFormat("dd/MM/yyyy").format(user.birthDate!),
            "Género": user.gender!,
          }),
        ),
        const SerManosSizedBox.lg(),
        SerManosInformationCard(
          title: "Datos de contacto",
          contentsByLabel: Map.from({
            "Teléfono": user.phoneNumber!,
            "E-mail": user.email!,
          }),
        ),
        const SerManosSizedBox.lg(),
      ],
    );
  }
}
