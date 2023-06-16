import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/edit_profile_photo_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/gender_input_card.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/contact_data_form.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/profile_data_form.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/routes/paths.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _disabled = true;
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return SerManosScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SerManosSpacing.spaceSL, vertical: 20),
                  child: SerManosIconButton(
                      icon: const SerManosIcon.close(),
                      onPressed: () => Navigator.pop(context)),
                ),
              ],
            ),
            const SerManosSizedBox.sl(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SerManosText.headline1("Datos de perfil"),
                const SerManosSizedBox.sl(),
                SerManosProfileDataForm(
                  currentPhotoUrl: "https://via.placeholder.com/150",
                  formKey: GlobalKey<FormState>(),
                  changeDisabledStateTo: (bool state) {
                    setState(() {
                      _disabled = state;
                    });
                  },
                ),
                const SerManosSizedBox.sm(),
                const SerManosSizedBox.lg(),
                SerManosContactDataForm(
                  formKey: _formKey,
                  changeDisabledStateTo: (bool state) {
                    setState(() {
                      _disabled = state;
                    });
                  },
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: SerManosText.caption(
                _error,
                color: SerManosColors.error100,
              ),
            ),
            SerManosTextButton.longTextButton(
              text: 'Iniciar Sesión',
              disabled: _disabled,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _error = ""; // TODO: Assign api response
                  });
                  if (_error.isEmpty) {
                    context.replaceNamed(SerManosPagesName.profile);
                  }
                }
              },
            ),
            const SerManosSizedBox.lg()
          ],
        ),
      ),
    );
  }
}
