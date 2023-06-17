import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/atoms/sized_box.dart';
import 'package:mobile_charity_app/design_system/molecules/inputs.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/current_voluntering_card.dart';
import 'package:mobile_charity_app/design_system/organisms/cards/volunteering_card.dart';
import 'package:mobile_charity_app/design_system/tokens/sizes.dart';
import 'package:mobile_charity_app/design_system/tokens/spacing.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';
import 'package:provider/provider.dart';

class VolunteeringsTab extends StatefulWidget {
  const VolunteeringsTab({
    super.key,
    required this.searchController,
    required this.currentVolunteeringTitle,
  });

  final TextEditingController searchController;
  final String? currentVolunteeringTitle;

  @override
  State<VolunteeringsTab> createState() => _VolunteeringsTabState();
}

class _VolunteeringsTabState extends State<VolunteeringsTab> {
  @override
  void initState() {
    super.initState();

    Provider.of<VolunteeringProvider>(context, listen: false)
        .fetchVolunteerings();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SerManosSizedBox.lg(),
          SerManosSearchField(controller: widget.searchController),
          const SerManosSizedBox.lg(),
          if (widget.currentVolunteeringTitle != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SerManosText.headline1("Tu actividad"),
                const SerManosSizedBox.sl(),
                SerManosCurrentVolunteringCard(
                  title: widget.currentVolunteeringTitle,
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
          RefreshIndicator(
              onRefresh:
                  Provider.of<VolunteeringProvider>(context, listen: false)
                      .fetchVolunteerings,
              child: Consumer<VolunteeringProvider>(
                builder: (context, volunteeringProvider, child) =>
                    volunteeringProvider.isLoading
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
                                      .getVolunteeringByIndex(index),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SerManosSizedBox.md(),
                            itemCount:
                                volunteeringProvider.volunteeringsMap.length,
                          ),
              )),
        ],
      ),
    );
  }
}
