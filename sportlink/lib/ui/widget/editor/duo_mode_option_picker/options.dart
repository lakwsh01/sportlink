import 'package:easy_localization/easy_localization.dart';

const _locale = "duo_mode_option_picker";

enum DuoModePickerOptionType { alphabet, numeric }

const _alphabet = "abcdefghijklmnopqrstuvwxyz";

extension DuoModePickerOptionTypeMethod on DuoModePickerOptionType {
  List<String> get options {
    switch (this) {
      case DuoModePickerOptionType.alphabet:
        return _alphabet.split("");
      case DuoModePickerOptionType.numeric:
        return List.generate(99, (index) => "$index");
      default:
        throw ArgumentError.value(this);
    }
  }

  String get keyboardTypeLabel {
    switch (this) {
      case DuoModePickerOptionType.alphabet:
        return "$_locale.keyboard_type_alphabet".tr();
      case DuoModePickerOptionType.numeric:
        return "$_locale.keyboard_type_numeric".tr();
      default:
        throw ArgumentError.value(this);
    }
  }

  String item(int index) {
    switch (this) {
      case DuoModePickerOptionType.alphabet:
        return _alphabet[index];

      default:
        return index.toString();
    }
  }
}
