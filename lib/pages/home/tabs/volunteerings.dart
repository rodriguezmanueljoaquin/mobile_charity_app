import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/current_voluntering_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:provider/provider.dart';

class VolunteeringsTab extends StatefulWidget {
  const VolunteeringsTab({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  State<VolunteeringsTab> createState() => _VolunteeringsTabState();
}

class _VolunteeringsTabState extends State<VolunteeringsTab>
    with AutomaticKeepAliveClientMixin<VolunteeringsTab> {
  @override
  void initState() {
    super.initState();

    VolunteeringProvider volunteeringProvider =
        Provider.of<VolunteeringProvider>(context, listen: false);
    if (volunteeringProvider.volunteerings == null) {
      volunteeringProvider.fetchVolunteerings();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Provider.of<VolunteeringProvider>(context, listen: false)
          .fetchVolunteerings()
          .then((_) =>
              Provider.of<UserProvider?>(context, listen: false)?.fetchUser()),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              kToolbarHeight,
          child: Column(
            children: [
              const SerManosSizedBox.lg(),
              SerManosSearchField(controller: widget.searchController),
              const SerManosSizedBox.lg(),
              Consumer2<UserProvider, VolunteeringProvider>(
                builder: (context, userProvider, volunteeringProvider, child) {
                  String? currentVolunteeringId =
                      userProvider.user?.currentVolunteeringId;
                  if (currentVolunteeringId == null) {
                    return const SizedBox();
                  }

                  String? currentVolunteeringTitle = volunteeringProvider
                      .getVolunteeringById(currentVolunteeringId)
                      ?.title;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SerManosText.headline1("Tu actividad"),
                      const SerManosSizedBox.sl(),
                      SerManosCurrentVolunteringCard(
                        title: currentVolunteeringTitle,
                      ),
                      const SerManosSizedBox.md(),
                    ],
                  );
                },
              ),
              SizedBox(
                width: SerManosSizes.sizeLG,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SerManosText.headline1("Voluntariados"),
                ),
              ),
              Consumer<VolunteeringProvider>(
                builder: (context, volunteeringProvider, child) =>
                    volunteeringProvider.isFetchingVolunteerings
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: SerManosSpacing.spaceSL,
                              vertical: SerManosSpacing.spaceMD,
                            ),
                            itemBuilder: (context, index) {
                              return UnconstrainedBox(
                                child: SerManosVolunteeringCard(
                                  volunteering: volunteeringProvider
                                      .volunteerings![index],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SerManosSizedBox.md(),
                            itemCount:
                                volunteeringProvider.volunteerings!.length,
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
