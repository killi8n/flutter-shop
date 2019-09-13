import 'dart:core';

class StringUtil {
  static makeCommaedString(int value) {
    if (value == 0) {
      return '0';
    }

    final sign = (value >= 0) ? '' : '-';

    int absValue = value.abs();

    final valueStrs = <String>[];

    while (absValue > 0) {
      final v = absValue % 1000;
      absValue = absValue ~/ 1000;

      if (absValue > 0) {
        valueStrs.add('$v'.padLeft(3, '0'));
      } else {
        valueStrs.add('$v');
      }
    }

    return sign + valueStrs.reversed.join(',');
  }
}
