import 'dart:convert';

import 'dart:io';

import 'package:dio/dio.dart';

class GAS {
  Future<Map<String, dynamic>?> upload(File image, String name, String type) {
    return Dio(BaseOptions(
            contentType: "application/json",
            headers: {"Accept": "application/json"},
            validateStatus: (status) => (status ?? 0) < 500,
            followRedirects: true))
        .post(
            "https://script.google.com/macros/s/AKfycbxJiKdEhc_ii0czdNhA6XDkNpmnfkWHWaOaq2hfBozgVpBa3YGJ4a4mohe3vM8jXmLU/exec",
            data: {
          "content": base64Encode(image.readAsBytesSync()),
          "name": name,
          "contentType": type
        }).then((value) async {
      return await Dio()
          .get(value.headers["location"]![0])
          .then((value) => jsonDecode(value.data) as Map<String, dynamic>);
    }).onError((error, stackTrace) {
      print(error);
      return {};
    });
  }
}
