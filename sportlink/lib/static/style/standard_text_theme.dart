import 'package:flutter/material.dart';

/// Text Theme for text
enum StandardTextTheme { standard }

/// Text Theme for button
enum StandardButtonTextTheme { standard, confirm, cancel, send }

extension StandardButtonTextThemeMethod on StandardButtonTextTheme {
  TextTheme get texttheme {
    switch (this) {
      case StandardButtonTextTheme.cancel:
        return const TextTheme();
      case StandardButtonTextTheme.confirm:
        return const TextTheme();
      case StandardButtonTextTheme.send:
        return const TextTheme();
      default:
        return const TextTheme();
    }
  }
}
