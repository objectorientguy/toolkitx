import 'package:encrypt/encrypt.dart';

class EncryptData {
  static final key = Key.fromLength(32);
  static final iv = IV.fromLength(16);
  static final encryptValue = Encrypter(AES(key));

  static encryptAES(text) {
    final encrypted = encryptValue.encrypt(text, iv: iv).base16;
    return encrypted;
  }

  static decryptAES(text) {
    return encryptValue.decrypt64(text, iv: iv);
  }
}
