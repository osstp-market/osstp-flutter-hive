import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'logger.dart';

const _usage = 'Usage: dart hash.dart <md5|sha1|sha256> <input_filename>';

/// Use MD5
String cryptoMD5(String data) {
  Uint8List content = const Utf8Encoder().convert(data);
  Digest digest = md5.convert(content);
  return digest.toString();
}

//RSA 公钥加密
Future cryptoByPem(String content) async {
  //加载公钥字符串
  final publicPem = await rootBundle.loadString('assets/crypto/rsa_pub_key.pem');
  //创建公钥对象
  RSAPublicKey publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
  //创建加密器
  final encrypt = Encrypter(RSA(publicKey: publicKey, digest: RSADigest.SHA256));

  return encrypt.encrypt(content).base64;
}
