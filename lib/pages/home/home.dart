import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/pages/home/tabs/news.dart';
import 'package:mobile_charity_app/pages/home/tabs/profile.dart';
import 'package:mobile_charity_app/pages/home/tabs/volunteerings.dart';
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

    return DefaultTabController(
      length: 3,
      initialIndex: widget.tab,
      child: Scaffold(
        backgroundColor: widget.tab == 1
            ? SerManosColors.neutral0
            : SerManosColors.secondary10,
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
                    text: 'Postularse',
                  ),
                  Tab(
                    text: 'Mi perfil',
                  ),
                  Tab(
                    text: 'Novedades',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            VolunteeringsTab(
                searchController: searchController,
            ),
            const ProfileTab(),
            const NewsTab(),
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
