import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/news_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(89.0),
            child: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [SerManosLogos.appBar, const Spacer()],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: ColoredBox(
                  color: Colors.blue[300]!,
                  child: TabBar(
                    unselectedLabelColor: Color.fromARGB(255, 216, 244, 54),
                    indicator: BoxDecoration(
                      color: Colors.blue[500]!,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white, // Color for the indicator line
                          width: 2.0, // Thickness of the indicator line
                        ),
                      ),
                    ),
                    tabs: [
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
            )),
        body: TabBarView(
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: SerManosSpacing.spaceSL,
                vertical: SerManosSpacing.spaceMD,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return SerManosSearchField(controller: searchController);
                }

                return const VolunteeringCard(
                  category: 'Acción Social',
                  title: 'Un Techo para mi País',
                  description:
                      'A dos horas al sur de Vicente López en la ciudad de Buenos Aires.',
                );
              },
              separatorBuilder: (context, index) => index == 0
                  ? const SerManosSizedBox.lg()
                  : const SerManosSizedBox.md(),
              itemCount: 5 + 1,
            ),
            Container(
              color: Colors.amberAccent,
              child: Center(
                child: Text('Mi Perfil'),
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: SerManosSpacing.spaceSL,
                vertical: SerManosSpacing.spaceLG,
              ),
              itemBuilder: (context, index) => NewsCard(
                overline: 'reporte 2820',
                title: 'Ser donante voluntario',
                body:
                    'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
              ),
              separatorBuilder: (context, index) => const SerManosSizedBox.md(),
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
