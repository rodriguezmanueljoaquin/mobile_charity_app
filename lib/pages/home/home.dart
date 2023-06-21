import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_charity_app/design_system/atoms/images.dart';
import 'package:mobile_charity_app/design_system/molecules/scaffolds.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/pages/home/tabs/news.dart';
import 'package:mobile_charity_app/pages/home/tabs/profile.dart';
import 'package:mobile_charity_app/pages/home/tabs/volunteerings.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:mobile_charity_app/routes/home_tabs.dart';
import 'package:mobile_charity_app/utils/geolocator.dart';
import 'package:mobile_charity_app/utils/handle_exception.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  int activeTabIndex;
  HomePage({super.key, this.activeTabIndex = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        requestLocationPermission()
            .then(
              (value) => Provider.of<UserProvider>(context, listen: false)
                  .loadLocation()
                  .then(
                (location) {
                  if (location != null) {
                    Provider.of<VolunteeringProvider>(context, listen: false)
                        .sortVolunteeringsByDistance();
                  }
                },
              ),
            )
            .catchError(
                (error) => handleException(context: context, error: error)));
  }

  void _onTap(int tabIndex) {
    if (tabIndex == widget.activeTabIndex) return;

    final tab = HomeTabs.values[tabIndex];

    Router.neglect(context, () => context.replaceNamed(tab.pageName));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: HomeTabs.values.length,
      initialIndex: widget.activeTabIndex,
      child: SerManosLightBlueScaffold(
        backgroundColor: widget.activeTabIndex == HomeTabs.profile.index
            ? SerManosColors.neutral0
            : SerManosColors.secondary10,
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
                    color:
                        SerManosColors.neutral0, // Color for the indicator line
                    width: 3.0, // Thickness of the indicator line
                  ),
                ),
              ),
              tabs: HomeTabs.values
                  .map(
                    (tab) => Tab(
                      text: tab.tabText,
                    ),
                  )
                  .toList(),
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
