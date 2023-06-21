import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffolds.dart';
import 'package:mobile_charity_app/utils/genders_constants.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/contact_data_form.dart';
import 'package:mobile_charity_app/design_system/organisms/forms/profile_data_form.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/user.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/utils/handle_exception.dart';
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
  bool _contactFormCompleted = false;
  bool _profileFormCompleted = false;

  bool _loading = false;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _image;
  int? _genderIdSelected;
  String _error = '';
  String? _currentPhotoUrl;

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
    _currentPhotoUrl = user.downloadAvatarURL;
    _profileFormCompleted = user.birthDate != null && user.gender != null;
    _contactFormCompleted = user.phoneNumber != null && user.email != null;
    _disabled = !(_profileFormCompleted && _contactFormCompleted);
  }

  void onImageChange(File? image) {
    setState(() {
      _image = image;
    });
  }

  void _submit() async {
    if (_contactFormCompleted && _profileFormCompleted) {
      setState(() {
        _disabled = true;
        _loading = true;
        _error = '';
      });
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);

      bool hasErrors = false;

      await userProvider
          .updateProfile(
            phoneNumber: _phoneController.text,
            email: _emailController.text,
            birthDate: DateFormat('dd/MM/yyyy').parse(_dateController.text),
            gender: genderStrById[_genderIdSelected],
            avatar: _image,
          )
          .then((value) =>
              FirebaseAnalytics.instance.logEvent(name: 'edit_profile'))
          .catchError(
        (error) {
          handleException(
            context: context,
            error: error,
            onFormException: (message) => setState(() => _error = message),
          );
          hasErrors = true;
        },
      );

      setState(() {
        _disabled = false;
        _loading = false;
      });

      if (!hasErrors) {
        context.pop();
      }
    }
  }

  void checkForm() {
    if (_profileFormCompleted && _contactFormCompleted && _disabled) {
      setState(() {
        _disabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SerManosDefaultScaffold(
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
                  alignment: Alignment.centerLeft,
                  child: SerManosText.headline1("Datos de perfil"),
                ),
                const SerManosSizedBox.sl(),
                SerManosProfileDataForm(
                  dateController: _dateController,
                  currentPhotoUrl: _currentPhotoUrl,
                  formKey: _profileDataFormKey,
                  onImageChange: onImageChange,
                  onGenderChange: (id) => _genderIdSelected = id,
                  genderValue: _genderIdSelected,
                  changeDisabledStateTo: (bool state) {
                    _profileFormCompleted =
                        !state; // if state is true, form is not completed (buttonn has to be disabled)
                    checkForm();
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
                    _contactFormCompleted =
                        !state; // if state is true, form is not completed (buttonn has to be disabled)
                    checkForm();
                  },
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: SerManosSpacing.spaceSM),
              child: SerManosText.caption(
                _error,
                color: SerManosColors.error100,
              ),
            ),
            SerManosTextButton.longTextButton(
              text: 'Guardar datos',
              disabled: _disabled,
              loading: _loading,
              onPressed: _submit,
            ),
            const SerManosSizedBox.lg()
          ],
        ),
      ),
    );
  }
}
