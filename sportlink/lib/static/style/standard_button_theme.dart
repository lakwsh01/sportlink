import 'package:flutter/material.dart';

enum StandardButtonStyleType { standard, confirm, cancel, send, inlineSetting }

extension StandardButtonStyleTypeMethod on StandardButtonStyleType {
  ButtonStyle get style {
    switch (this) {
      case StandardButtonStyleType.confirm:
        return _confirm;
      case StandardButtonStyleType.cancel:
        return _cancel;
      case StandardButtonStyleType.send:
        return _send;
      case StandardButtonStyleType.inlineSetting:
        return _inlineSetting;
      default:
        return _standard;
    }
  }
}

const _standard =
    ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orange));
const _confirm = ButtonStyle();
const _cancel = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Colors.transparent),
    foregroundColor: MaterialStatePropertyAll(Colors.grey));
const _send = ButtonStyle();
final _inlineSetting = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Colors.orange[50]),
    foregroundColor: MaterialStatePropertyAll(Colors.orange));
