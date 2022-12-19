import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FieldRuleView extends StatelessWidget {
  final List<String> rules;
  final ScrollController? controller;
  final bool scrollAvailable;

  const FieldRuleView(
      {required this.rules,
      this.controller,
      this.scrollAvailable = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.8),
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.7, 0.85, 1])),
        child: ListView.builder(
            controller: controller,
            physics:
                scrollAvailable ? null : const NeverScrollableScrollPhysics(),
            itemCount: rules.length + 2,
            itemBuilder: (_, int index) {
              if (index == 0) {
                return Text("game-apply.field-rule-title".tr(),
                    style: Theme.of(context).textTheme.titleLarge);
              } else if (index == rules.length + 1) {
                return const SizedBox(height: 180);
              } else {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text("$index. ${rules.elementAt(index - 1)}",
                        style: Theme.of(context).textTheme.bodyLarge));
              }
            }));
  }
}
