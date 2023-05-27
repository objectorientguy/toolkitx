import 'package:encrypt/encrypt.dart';

class EncryptData {
  static final key = Key.fromUtf8('8a9373b2a1b9f7e0984351dcea683675');
  static final iv = IV.fromUtf8('8080808080808080');
  static final encryptValue = Encrypter(AES(key, mode: AESMode.cbc));

  static encryptAES(text) {
    final encrypted = encryptValue.encrypt(text, iv: iv).base64;
    return encrypted;
  }

  static decryptAES(text) {
    final decrypted = encryptValue.decrypt64(text, iv: iv);
    return decrypted;
  }
}
