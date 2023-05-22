import 'dart:developer';

import 'package:encrypt/encrypt.dart';

class EncryptData {
//for AES Algorithms

  static Encrypted? encrypted;
  static String? decrypted;

  static encryptAES(plainText) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    log(encrypted!.base64);
  }

  static decryptAES(plainText) {
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    decrypted = encrypter.decrypt(encrypted!, iv: iv);
    log(decrypted!);
  }
}
