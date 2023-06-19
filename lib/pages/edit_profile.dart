import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffold.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/edit_profile_photo_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/gender_input_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/genders_constants.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/contact_data_form.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/profile_data_form.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/routes/paths.dart';
import 'package:mobile_charity_app/utils/logger.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _profileDataFormKey = GlobalKey<FormState>();
  final _contactDataFormKey = GlobalKey<FormState>();
  bool _disabled = true;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  int? _genderIdSelected;
  String _error = '';

  @override
  void initState() {
    super.initState();

    final UserModel user =
        Provider.of<UserProvider>(context, listen: false).user!;
    _dateController.text = user.birthDate != null
        ? DateFormat('dd/MM/yyyy').format(user.birthDate!)
        : '';
    _phoneController.text = user.phoneNumber ?? '';
    _emailController.text = user.email ?? '';
    _genderIdSelected = genderIdByName[user.gender];
  }

  void _submit() async {
    if (_contactDataFormKey.currentState!.validate()) {
      setState(() {
        _disabled = true;
      });
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);

      final UserModel updatedUser = userProvider.user!.copyWith(
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        birthDate: DateFormat('dd/MM/yyyy').parse(_dateController.text),
        gender: genderStrById[_genderIdSelected],
      );

      await userProvider.updateProfile(updatedUser);

      setState(() {
        _error = ""; // TODO: Assign api response
        _disabled = false;
      });
      if (_error.isEmpty) {
        context.replaceNamed(SerManosPagesName.profile);
      }
    }
  }

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
                      onPressed: () => context.pop()),
                ),
              ],
            ),
            const SerManosSizedBox.sl(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SerManosSizes.sizeLG,
                  alignment: Alignment.centerLeft,
                  child: SerManosText.headline1("Datos de perfil"),
                ),
                const SerManosSizedBox.sl(),
                SerManosProfileDataForm(
                  dateController: _dateController,
                  currentPhotoUrl: "https://via.placeholder.com/150",
                  formKey: _profileDataFormKey,
                  onGenderChange: (id) => _genderIdSelected = id,
                  genderValue: _genderIdSelected,
                  changeDisabledStateTo: (bool state) {
                    setState(() {
                      _disabled = state;
                    });
                  },
                ),
                const SerManosSizedBox.sm(),
                const SerManosSizedBox.lg(),
                SerManosContactDataForm(
                  formKey: _contactDataFormKey,
                  onFieldSubmitted: _submit,
                  phoneController: _phoneController,
                  emailController: _emailController,
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
              text: 'Guardar datos',
              disabled: _disabled,
              onPressed: _submit,
            ),
            const SerManosSizedBox.lg()
          ],
        ),
      ),
    );
  }
}
