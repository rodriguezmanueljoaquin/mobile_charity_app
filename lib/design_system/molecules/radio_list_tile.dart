import 'package:flutter/material.dart';
import 'package:mobile_charity_app/design_system/tokens/colors.dart';
import 'package:mobile_charity_app/design_system/tokens/typography.dart';

class SerManosRadioListTile extends StatefulWidget {
  final Map<int, String> options;
  final Function(int) onGenderChange;
  final int? value;

  const SerManosRadioListTile(
      {super.key,
      required this.options,
      required this.onGenderChange,
      this.value});

  @override
  State<SerManosRadioListTile> createState() => _SerManosRadioListTileState();
}

class _SerManosRadioListTileState extends State<SerManosRadioListTile> {
  int? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (MapEntry option in widget.options.entries)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                // always green
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  return SerManosColors.primary100;
                }),
                value: option.key,
                groupValue: _selectedValue,
                onChanged: (id) {
                  widget.onGenderChange(id);
                  setState(() {
                    _selectedValue = id;
                  });
                },
              ),
              SerManosText.body1(option.value)
            ],
          )
      ],
    );
  }
}
