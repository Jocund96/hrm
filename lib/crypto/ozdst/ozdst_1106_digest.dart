// ignore_for_file: constant_identifier_names
// ignore_for_file: non_constant_identifier_names

import '../gost/gost_28147_engine.dart';
import '../gost/key_parameter.dart';
import '../gost/parameters_with_sbox.dart';

class OzDSt1106Digest {
  static const _DIGEST_LENGTH = 32;

  final _H = List.filled(32, 0);
  final _L = List.filled(32, 0);
  final _M = List.filled(32, 0);
  final _Sum = List.filled(32, 0);
  final List<List<int>?> _C = List.filled(4, null);
  final _xBuf = List.filled(32, 0);
  final _cipher = GOST28147Engine();

  int _xBufOff = 0;
  int _byteCount = 0;

  List<int> _sBox = [];

  static _arraycopy(List<int> inp, int inOff, List<int> out, int outOff, int length) {
    for (int i = 0; i < length; i++) {
      if (i + inOff >= inp.length) break;
      out[i + outOff] = inp[i + inOff];
    }
  }

  OzDSt1106Digest(List<int> sBoxParam) {
    _sBox = List.filled(sBoxParam.length, 0);
    _arraycopy(sBoxParam, 0, _sBox, 0, sBoxParam.length);
    _cipher.init(true, ParametersWithSBox(null, _sBox));
    reset();
  }

  String get algorithmName => 'OzDSt1106';

  int get digestSize => OzDSt1106Digest._DIGEST_LENGTH;

  void updateByte(int inp) {
    _xBuf[_xBufOff++] = inp;
    if (_xBufOff == _xBuf.length) {
      _sumByteArray(_xBuf);
      _processBlock(_xBuf, 0);
      _xBufOff = 0;
    }
    _byteCount++;
  }

  void updateBuffer(List<int> inp, int inOff, int len) {
    while ((_xBufOff != 0) && (len > 0)) {
      updateByte(inp[inOff]);
      inOff++;
      len--;
    }

    while (len > _xBuf.length) {
      _arraycopy(inp, inOff, _xBuf, 0, _xBuf.length);
      _sumByteArray(_xBuf);
      _processBlock(_xBuf, 0);
      inOff += _xBuf.length;
      len -= _xBuf.length;
      _byteCount += _xBuf.length;
    }

    while (len > 0) {
      updateByte(inp[inOff]);
      inOff++;
      len--;
    }
  }

  final _K = List.filled(32, 0);

  List<int> _P(List<int> inp) {
    for (int k = 0; k < 8; k++) {
      _K[4 * k] = inp[k];
      _K[1 + 4 * k] = inp[8 + k];
      _K[2 + 4 * k] = inp[16 + k];
      _K[3 + 4 * k] = inp[24 + k];
    }
    return _K;
  }

  final _a = List.filled(8, 0);

  List<int> _A(List<int> inp) {
    for (int j = 0; j < 8; j++) {
      _a[j] = (inp[j] ^ inp[j + 8]) & 0xFF;
    }
    _arraycopy(inp, 8, inp, 0, 24);
    _arraycopy(_a, 0, inp, 24, 8);
    return inp;
  }

  void _E(List<int> key, List<int> s, int sOff, List<int> inp, int inOff) {
    _cipher.init(true, KeyParameter(key));
    _cipher.processBlock(inp, inOff, s, sOff);
  }

  final _wS = List.filled(16, 0);
  final _w_S = List.filled(16, 0);

  void _fw(List<int> inp) {
    _cpyBytesToShort(inp, _wS);
    _w_S[15] = (_wS[0] ^ _wS[1] ^ _wS[2] ^ _wS[3] ^ _wS[12] ^ _wS[15]) & 0xFFFF;
    _arraycopy(_wS, 1, _w_S, 0, 15);
    _cpyShortToBytes(_w_S, inp);
  }

  List<int> _V = List.filled(32, 0);
  final _S = List.filled(32, 0);
  final _U = List.filled(32, 0);
  final _W = List.filled(32, 0);

  void _processBlock(List<int> inp, int inOff) {
    _arraycopy(inp, inOff, _M, 0, 32);
    _arraycopy(_H, 0, _U, 0, 32);
    _arraycopy(_M, 0, _V, 0, 32);

    for (int j = 0; j < 32; j++) {
      _W[j] = (_U[j] ^ _V[j]) & 0xFF;
    }

    _E(_P(_W), _S, 0, _H, 0);

    for (int i = 1; i < 4; i++) {
      List<int> tmpA = _A(_U);

      for (int j = 0; j < 32; j++) {
        _U[j] = (tmpA[j] ^ _C[i]![j]) & 0xFF;
      }

      _V = _A(_A(_V));

      for (int j = 0; j < 32; j++) {
        _W[j] = (_U[j] ^ _V[j]) & 0xFF;
      }

      _E(_P(_W), _S, i * 8, _H, i * 8);
    }

    for (int n = 0; n < 12; n++) {
      _fw(_S);
    }

    for (int n = 0; n < 32; n++) {
      _S[n] = (_S[n] ^ _M[n]) & 0xFF;
    }

    _fw(_S);

    for (int n = 0; n < 32; n++) {
      _S[n] = (_H[n] ^ _S[n]) & 0xFF;
    }

    for (int n = 0; n < 61; n++) {
      _fw(_S);
    }

    _arraycopy(_S, 0, _H, 0, _H.length);
  }

  static void _intToLittleEndian(int n, List<int> bs, int off) {
    bs[off] = (n) & 0xFF;
    bs[++off] = ((n & 0xFFFFFFFF) >> 8) & 0xFF;
    bs[++off] = ((n & 0xFFFFFFFF) >> 16) & 0xFF;
    bs[++off] = ((n & 0xFFFFFFFF) >> 24) & 0xFF;
  }

  static void _longToLittleEndian(int n, List<int> bs, int off) {
    _intToLittleEndian((n) & 0xffffffff, bs, off);
  }

  void finish() {
    _longToLittleEndian(_byteCount * 8, _L, 0);

    while (_xBufOff != 0) {
      updateByte(0 & 0xFF);
    }

    _processBlock(_L, 0);
    _processBlock(_Sum, 0);
  }

  int doFinal(List<int> out, int outOff) {
    finish();
    _arraycopy(_H, 0, out, outOff, _H.length);
    reset();
    return OzDSt1106Digest._DIGEST_LENGTH;
  }

  final List<int> _C2 = [
    0x00,
    0xFF,
    0x00,
    0xFF,
    0x00,
    0xFF,
    0x00,
    0xFF,
    0xFF,
    0x00,
    0xFF,
    0x00,
    0xFF,
    0x00,
    0xFF,
    0x00,
    0x00,
    0xFF,
    0xFF,
    0x00,
    0xFF,
    0x00,
    0x00,
    0xFF,
    0xFF,
    0x00,
    0x00,
    0x00,
    0xFF,
    0xFF,
    0x00,
    0xFF
  ];

  void reset() {
    for (int i = 0; i < _C.length; i++) {
      _C[i] = List.filled(32, 0);
    }
    _byteCount = 0;
    _xBufOff = 0;

    _H.fillRange(0, _H.length, 0);
    _L.fillRange(0, _L.length, 0);
    _M.fillRange(0, _M.length, 0);
    _C[1]!.fillRange(0, _C[1]!.length, 0);
    _C[3]!.fillRange(0, _C[3]!.length, 0);
    _Sum.fillRange(0, _Sum.length, 0);
    _xBuf.fillRange(0, _xBuf.length, 0);

    _arraycopy(_C2, 0, _C[2]!, 0, _C2.length);
  }

  void _sumByteArray(List<int> inp) {
    int carry = 0;
    for (int i = 0; i != _Sum.length; i++) {
      int sum = (_Sum[i] & 0xff) + (inp[i] & 0xff) + carry;
      _Sum[i] = sum & 0xFF;
      carry = (sum & 0xFFFFFFFF) >> 8;
    }
  }

  void _cpyBytesToShort(List<int> S, List<int> wS) {
    for (int i = 0; i < S.length / 2; i++) {
      wS[i] = (((S[i * 2 + 1] << 8) & 0xFF00) | (S[i * 2] & 0xFF)) & 0xFFFF;
    }
  }

  void _cpyShortToBytes(List<int> wS, List<int> S) {
    for (int i = 0; i < S.length / 2; i++) {
      S[i * 2 + 1] = (wS[i] >> 8) & 0xFF;
      S[i * 2] = wS[i] & 0xFF;
    }
  }

  int get ByteLength => 32;
}
