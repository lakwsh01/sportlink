import 'package:easy_localization/easy_localization.dart';

enum LocaleInitial { genericButtonLabel, gender }

extension LocaleInitialMethod on LocaleInitial {
  String get initial {
    switch (this) {
      case LocaleInitial.genericButtonLabel:
        return "generic_button_lable";

      case LocaleInitial.gender:
        return "gender";

      default:
        throw ArgumentError.value(this);
    }
  }

  String labelAt(String anchor) {
    switch (this) {
      case LocaleInitial.genericButtonLabel:
        return "generic_button_lable.$anchor".tr();

      case LocaleInitial.gender:
        return "gender.$anchor".tr();

      default:
        throw ArgumentError.value(this);
    }
  }
}
