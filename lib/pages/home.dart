import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/components.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/current_voluntering_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/gender_input_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/news_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/routes/paths.dart';

class HomePage extends StatefulWidget {
  int tab;
  HomePage({super.key, this.tab = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  void _onTap(int tab) {
    if (tab == widget.tab) return;

    String pageName = "";
    switch (tab) {
      case 0:
        pageName = SerManosPagesName.volunteering;
        break;
      case 1:
        pageName = SerManosPagesName.profile;
        break;
      case 2:
        pageName = SerManosPagesName.news;
        break;
    }

    Router.neglect(context, () => context.replaceNamed(pageName));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Remove hardcoded data
    String? currentVolunteeringTitle = "Techo para mi pais";
    // String? currentVolunteeringTitle;

    return DefaultTabController(
      length: 3,
      initialIndex: widget.tab,
      child: Scaffold(
        backgroundColor: SerManosColors.secondary10,
        appBar: AppBar(
          backgroundColor: SerManosColors.secondary90,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: SerManosColors.secondary90,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [SerManosImages.appBar, const Spacer()],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: ColoredBox(
              color: SerManosColors.secondary100,
              child: TabBar(
                unselectedLabelColor: SerManosColors.neutral0,
                onTap: _onTap,
                indicator: const BoxDecoration(
                  color: SerManosColors.secondary200,
                  border: Border(
                    bottom: BorderSide(
                      color: SerManosColors
                          .neutral0, // Color for the indicator line
                      width: 3.0, // Thickness of the indicator line
                    ),
                  ),
                ),
                tabs: const [
                  Tab(
                    text: 'POSTULARSE',
                  ),
                  Tab(
                    text: 'MI PERFIL',
                  ),
                  Tab(
                    text: 'NOVEDADES',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // POSTULARSE
            SingleChildScrollView(
                child: Column(
              children: [
                const SerManosSizedBox.lg(),
                SerManosSearchField(controller: searchController),
                const SerManosSizedBox.lg(),
                if (currentVolunteeringTitle != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SerManosText.headline1("Tu actividad"),
                      const SerManosSizedBox.sl(),
                      SerManosCurrentVolunteringCard(
                        title: currentVolunteeringTitle,
                      ),
                      const SerManosSizedBox.md(),
                    ],
                  ),
                SizedBox(
                  width: SerManosSizes.sizeLG,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SerManosText.headline1("Voluntariados"),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: SerManosSpacing.spaceSL,
                    vertical: SerManosSpacing.spaceMD,
                  ),
                  itemBuilder: (context, index) {
                    return const UnconstrainedBox(
                      child: SerManosVolunteeringCard(
                        // TODO: Remove hardcoded data
                        category: 'Acción Social',
                        volunteering: VolunteeringModel(
                          id: '1',
                          title: 'Un Techo para mi País',
                          description:
                              'A dos horas al sur de Vicente López en la ciudad de Buenos Aires.',
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SerManosSizedBox.md(),
                  itemCount: 5,
                ),
              ],
            )),

            // MI PERFIL
            SingleChildScrollView(
                child: Column(
              children: [
                const SerManosSizedBox.lg(),
                Container(
                  child: const Center(
                    child: SerManosProfilePhoto(url: null),
                  ),
                ),
                SerManosGenderInputCard(),
              ],
            )),

            // NOVEDADES
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: SerManosSpacing.spaceSL,
                vertical: SerManosSpacing.spaceLG,
              ),
              itemBuilder: (context, index) => const UnconstrainedBox(
                child: SerManosNewsCard(
                  overline: 'reporte 2820',
                  title: 'Ser donante voluntario',
                  body:
                      'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
                ),
              ),
              separatorBuilder: (context, index) => const SerManosSizedBox.md(),
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void didUpdateWidget(covariant HomePage oldWidget) {
  //   if (oldWidget.tab != widget.tab) {
  //     DefaultTabController.of(context).animateTo(widget.tab);
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }
}
