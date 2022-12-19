extension IntMethod on int {
  static String toStringAsFixedDigit({required int value, int digit = 2}) {
    final String _arg = value.toString();
    if (_arg.length > digit) {
      return value.toStringAsExponential(digit);
    } else if (_arg.length < digit) {
      final String preFix =
          (List.generate(digit - _arg.length, (index) => "0")).join();
      return [preFix, _arg].join();
    } else {
      return _arg;
    }
  }

  static String toTimeDisplay({required int value, String format = "mn分ss秒"}) {
    final mn = (value / 60).floor();
    final ss = value - (mn * 60);

    String display = format.replaceFirst("mn", "$mn");
    display = display.replaceFirst("ss", "$ss");
    return display;
  }
}
