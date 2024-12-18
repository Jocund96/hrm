import 'gost/gost_28147_engine.dart';
import 'hex.dart';
import 'ozdst/ozdst_1106_digest.dart';

class GostHash {
  static List<int> hash(List<int> data, {String sBoxName = 'D_A'}) {
    final sbox = GOST28147Engine.getSBox(sBoxName);
    final digest = OzDSt1106Digest(sbox);

    digest.reset();
    digest.updateBuffer(data, 0, data.length);

    final h = List.filled(digest.digestSize, 0);

    digest.doFinal(h, 0);

    return h;
  }

  static String hashGost2Hex(List<int> raw) {
    return Hex.fromBytes(hash(raw));
  }
}
