import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/routes/paths.dart';
import 'package:provider/provider.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn =
        Provider.of<UserProvider>(context, listen: false).user != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SerManosColors.secondary90,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: SerManosColors.secondary90,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [SerManosImages.appBar, const Spacer()],
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SerManosText.headline2('Oops! No encontramos la página que buscas.'),
          const SerManosSizedBox.md(),
          SerManosTextButton.longTextButton(
              text: isLoggedIn ? 'Ir al inicio' : 'Iniciar sesión',
              onPressed: () => context.pushReplacementNamed(isLoggedIn
                  ? SerManosPagesName.volunteering
                  : SerManosPagesName.signin)),
        ],
      )),
    );
  }
}
