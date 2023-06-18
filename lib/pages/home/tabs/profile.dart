import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/information_card.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/routes/paths.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  final bool completed = true;
  final String _mail = "asdasd@asdasda.asdasd";
  final String _phoneNumber = "123123123";
  final String name = "Juan Cruz Gonzales";
  final double _toolbarHeight;

  const ProfileTab({
    super.key,
    required double toolbarHeight,
  }) : _toolbarHeight = toolbarHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(
                    child: SerManosProfilePhoto(url: null),
                  ),
                  const SerManosSizedBox.sl(),
                  SerManosText.overline("VOLUNTARIO"),
                  const SerManosSizedBox.sm(),
                  SerManosText.subtitle1(name),
                  const SerManosSizedBox.sm(),
                  completed
                      ? SerManosText.body1(
                          _mail,
                          color: SerManosColors
                              .secondary200, // TODO: ADD HIPERVINCULO AL MAIL
                        )
                      : SerManosText.body1(
                          "¡Completá tu perfil para tener acceso a mejores oportunidades!"),
                  if (completed) const SerManosSizedBox.lg(),
                  if (completed)
                    ProfileData(
                      mail: _mail,
                      phoneNumber: _phoneNumber,
                    )
                ],
              ),
            ),
          ),
        ),
        completed
            ? Column(
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
                    onPressed: () async {
                      return await Provider.of<UserProvider>(
                        context,
                        listen: false,
                      ).logout().then(
                            (_) => context.replaceNamed(SerManosPagesName.signin),
                          );
                    },
                    filled: false,
                    textColor: SerManosColors.error100,
                  ),
                  const SerManosSizedBox.xl(),
                ],
              )
            : Column(
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
      ],
    );
  }
}

class ProfileData extends StatelessWidget {
  final String _mail, _phoneNumber;

  const ProfileData({
    super.key,
    required String mail,
    required String phoneNumber,
  })  : _mail = mail,
        _phoneNumber = phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SerManosInformationCard(
          title: "Información personal",
          contentsByLabel: Map.from({
            "Fecha de nacimiento": "12/12/1999",
            "Género": "Masculino",
          }),
        ),
        const SerManosSizedBox.lg(),
        SerManosInformationCard(
          title: "Datos de contacto",
          contentsByLabel:
              Map.from({"Teléfono": _phoneNumber, "E-mail": _mail}),
        ),
        const SerManosSizedBox.lg(),
      ],
    );
  }
}
