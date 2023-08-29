import 'dart:convert';

import 'package:news/core/Errors/failure.dart';

mixin Parser {
  (Failure?, Map<String, dynamic>) stringToJson(String value) {
    try {
      final decode = jsonDecode(value);
      return (null, decode);
    } catch (e) {
      return (const JsonDecodeFailure(), {});
    }
  }

  (Failure?, String value) jsonToString(Map<String, dynamic> json) {
    try {
      final encode = jsonEncode(json);
      return (null, encode);
    } catch (e) {
      return (const JsonEncodeFailure(), "");
    }
  }
}
