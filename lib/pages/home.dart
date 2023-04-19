import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/icons.dart';
import 'package:mobile_charity_app/design_system/atoms/logos.dart';
import 'package:mobile_charity_app/design_system/molecules/buttons.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/utils/validators.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              VolunteeringCard(
                category: 'acción social',
                title: 'Un Techo para mi País',
                onFavorite: (bool isFavorite) {
                  print(isFavorite);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
