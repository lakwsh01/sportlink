import 'package:flutter/material.dart';

class ConditionLabel extends StatelessWidget {
  final String label;
  const ConditionLabel({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}
