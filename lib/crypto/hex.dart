class Hex {
  static String fromBytes(List<int> data) {
    var sb = StringBuffer();

    for (int i = 0; i < data.length; i++) {
      sb.write(data[i].toRadixString(16).padLeft(2, '0').toUpperCase());
    }
    return sb.toString();
  }

  static int _hexToInt(String hex) {
    int val = 0;
    int len = hex.length;

    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);

      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException('Invalid hexadecimal value');
      }
    }

    return val;
  }

  static List<int> toBytes(String hexStr) {
    hexStr = hexStr.replaceAll(' ', '');

    final bytes = List<int>.empty(growable: true);

    if (hexStr.length % 2 != 0) {
      hexStr = '0$hexStr';
    }

    for (var i = 0; i < hexStr.length / 2; i++) {
      final hexByte = hexStr.substring(i * 2, i * 2 + 2);
      final b = _hexToInt(hexByte);
      bytes.add(b);
    }

    return bytes;
  }
}
