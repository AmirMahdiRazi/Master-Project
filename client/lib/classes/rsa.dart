// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'package:encrypt/encrypt.dart';

import 'package:pointycastle/asymmetric/api.dart';

class Rsa {
  late final _publicKey;
  late final _privKey;
  late final Encrypter _encrypter;

  String encrypt(String plainText) =>
      _encrypter.encrypt(plainText).base64.toString();
  String decrypt(String encrypted) =>
      _encrypter.decrypt(Encrypted.fromBase64(encrypted)).toString();
  Rsa() {
    setKey();
  }

  void setKey() async {
    _publicKey = await getPublicKey<RSAPublicKey>();
    _privKey = await getPrivateKey<RSAPrivateKey>();
    _encrypter = Encrypter(RSA(
      publicKey: _publicKey,
      privateKey: _privKey,
      encoding: RSAEncoding.OAEP,
    ));
  }

  Future<T> getPrivateKey<T extends RSAAsymmetricKey>() async {
    // ignore: prefer_const_declarations
    final key = '''-----BEGIN PRIVATE KEY-----
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
iuYvfSUS0jXksSmdsiaPCW/kKdWp
-----END PRIVATE KEY-----''';
    final parser = RSAKeyParser();
    return parser.parse(key) as T;
  }

  Future<T> getPublicKey<T extends RSAAsymmetricKey>() async {
    // ignore: prefer_const_declarations
    final key = '''-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqsSjh1JLwVJMrkqg8Lby
E9vES0hM+70cmKiXBzWpGbf4kvnM8WHrY0mLq0yvaMdOMmq6H/3xTIfHRf+2Tjp1
1b5g3xE53MUR/ez2Z5oEhl+HexbzpezpiMhVajHOUZQwP3CsKs748p2M/cD4LKwx
tLopvMGfgpURkK6/Mdts+KYMoD3dJ9gTsUBOuBgZ8t1HHynWYIXKDvKpyrMvNSKW
Fby5nH7XMLTKe6mWZCgw6CH6ztBa8yc6pCYunqbCcMGv+oQmIWLjyW1F9qJCM6c3
wWG/mzibWSJKH60z6Crx0xBBGz9hEPkrn0jNciuX3eU/Er1m58KNuB6QdTOxxziX
tSHe2W4NlGA3JNWYNkBhQotfc6fqIxGRuOclp59cCP0KBfZYQKjgHHRFxMHND+2y
IQ2kmR14tLCIBSdyP30BUXo7K+RnzSHjvYdDUCc8UGmQ5lhVotuhvCvihXwHzOSt
Fq2TREu1FKNpMw/hhlArGTs5hhj6aNf1m1L7avfz0d/HCeaYHyUWs6BkIsPaxUz2
SHYSmUWWFdo5KwjiSRaRBUQQMuxOmgp41f3omcKREvpCpoh2UUotb8Klxq9TSANA
ypeR1LQTJ9w9j84s6K6M5bbFLB7z9a4V3xMt8ygJx7pdd0T7cI4xEOAuva3Idsut
DtE6A9wkE+QU1Mz2ow5OPIkCAwEAAQ==
-----END PUBLIC KEY-----''';
    final parser = RSAKeyParser();
    return parser.parse(key) as T;
  }
}
