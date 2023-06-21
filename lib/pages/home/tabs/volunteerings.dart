import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/current_voluntering_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/empty_list_placeholder_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/design_system/tokens/indicators.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:mobile_charity_app/utils/handle_exception.dart';
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
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    widget.searchController.addListener(_onSearchChanged);

    VolunteeringProvider volunteeringProvider =
        Provider.of<VolunteeringProvider>(context, listen: false);
    if (volunteeringProvider.volunteerings == null) {
      volunteeringProvider.fetchVolunteerings().catchError(
          (error) => handleException(context: context, error: error));
    }
  }

  @override
  bool get wantKeepAlive => true;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SerManosRefreshIndicator(
      onRefresh: () async {
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        return await userProvider
            .loadLocation()
            .then((_) =>
                Provider.of<VolunteeringProvider>(context, listen: false)
                    .fetchVolunteerings())
            .then((_) => userProvider.fetchUser())
            .catchError(
                (error) => handleException(context: context, error: error));
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: SerManosSpacing.spaceSL),
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  const SerManosSizedBox.lg(),
                  SerManosSearchField(
                    controller: widget.searchController,
                    onFieldSubmitted: (_) {},
                  ),
                  const SerManosSizedBox.lg(),
                  Consumer2<UserProvider, VolunteeringProvider>(
                    builder:
                        (context, userProvider, volunteeringProvider, child) {
                      String? currentVolunteeringId =
                          userProvider.user?.currentVolunteeringId;
                      if (currentVolunteeringId == null) {
                        return const SizedBox();
                      }

                      VolunteeringModel? currentVolunteering =
                          volunteeringProvider
                              .getVolunteeringById(currentVolunteeringId);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SerManosText.headline1("Tu actividad"),
                          const SerManosSizedBox.sl(),
                          SerManosCurrentVolunteringCard(
                            category: currentVolunteering?.category,
                            title: currentVolunteering?.title,
                            volunteeringId: currentVolunteeringId,
                          ),
                          const SerManosSizedBox.md(),
                        ],
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SerManosText.headline1("Voluntariados"),
                  ),
                  Consumer<VolunteeringProvider>(
                      builder: (context, volunteeringProvider, child) {
                    if (volunteeringProvider.isFetchingVolunteerings) {
                      return const Padding(
                        padding: EdgeInsets.only(top: SerManosSpacing.spaceMD),
                        child: Center(
                          child: SerManosProgressIndicator(),
                        ),
                      );
                    }

                    List<VolunteeringModel>? volunteerings =
                        volunteeringProvider.volunteerings;

                    if (widget.searchController.text.isNotEmpty) {
                      volunteerings = volunteeringProvider
                          .searchVolunteeringsByTitleAndDescription(
                              widget.searchController.text);
                    }

                    if (volunteerings == null || volunteerings.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SerManosSpacing.spaceMD,
                          ),
                          child: SerManosEmptyListPlaceholderCard(
                              text:
                                  "Actualmente no hay voluntariados vigentes. Pronto se irán ircorporando nuevos."),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: SerManosSpacing.spaceMD,
                      ),
                      itemBuilder: (context, index) {
                        return SerManosVolunteeringCard(
                          volunteering: volunteerings![index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SerManosSizedBox.md(),
                      itemCount: volunteerings.length,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
