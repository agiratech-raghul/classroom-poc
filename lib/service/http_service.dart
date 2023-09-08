import 'dart:convert';
import 'package:classroom_poc/Utils/typedef.dart';
import 'package:classroom_poc/Utils/utils.dart';
import 'package:classroom_poc/service/network_check.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class HttpService {
  //! HTTP Get API Calls.
  Future<JSON> get({
    required String endpoint,
    Map<String, String>? headers,
    JSON? queryParams,
    final dynamic Function(bool)? onError,
  }) async {
    final bool isNetworkAvailable = await NetworkCheck().check();
    if (isNetworkAvailable) {
      try {
        final response = await http.get(
          Uri.parse(endpoint),
          headers: headers ?? await picArtHeader(),
        );
        var responseJson = json.decode(response.body.toString());
        responseJson.putIfAbsent("status_code", () => response.statusCode);
        return responseJson;
      } on Exception catch (_) {}
    }
    return onError != null ? onError(isNetworkAvailable) : false;
  }

//! HTTP Post Api Call.
  Future<JSON> post(
      {required String endpoint,
      dynamic body,
      final dynamic Function(bool)? onError}) async {
    final bool isNetworkAvailable = await NetworkCheck().check();
    if (isNetworkAvailable) {
      debugPrint(body);

      try {
        final response = await http.post(
          Uri.parse(endpoint),
          headers: await picArtHeader(),
          // headers
          //     ? await authenticationHeaderWithoutcontent()
          //     : await addAuthenticationHeader(),
          body: body,
        );
        var responseJson = json.decode(response.body.toString());
        responseJson.putIfAbsent("status_code", () => response.statusCode);
        return responseJson;
      } on Exception catch (_) {
        debugPrint('$_');
      }
    }
    return onError != null ? onError(isNetworkAvailable) : null;
  }

  Future<JSON> multipartRequest(
      {required String endpoint,
      dynamic body,
      Map<String, String>? fields,
      dynamic body1,
      final dynamic Function(bool)? onError}) async {
    final bool isNetworkAvailable = await NetworkCheck().check();
    if (isNetworkAvailable) {
      try {
        debugPrint("endpoint ${Uri.parse(endpoint)}");
        debugPrint("filePath $body");
        var request = http.MultipartRequest("POST", Uri.parse(endpoint));
        request.headers.addAll(await picArtHeader());

        request.fields["upload_type"] = "attachement";
        if (body.isNotEmpty) {
          http.MultipartFile frontFile = await http.MultipartFile.fromPath(
              'image', body,
              contentType: MediaType('image', Uitls.getImageExtension(body)));
          if (body1 != null) {
            http.MultipartFile anotherFile = await http.MultipartFile.fromPath(
                'reference_image', body1,
                contentType: MediaType(
                    'reference_image', Uitls.getImageExtension(body1)));
            request.files.add(anotherFile);
          }
          request.files.add(frontFile);

          request.fields.addAll(fields!);
        }
        debugPrint("request $request");
        http.StreamedResponse response = await request.send();
        var respStr = await response.stream.bytesToString();
        var responseJson = json.decode(respStr.toString());
        responseJson.putIfAbsent("status_code", () => response.statusCode);
        return responseJson;
      } on Exception catch (_) {
        debugPrint('$_');
      }
    }
    return onError != null ? onError(isNetworkAvailable) : false;
  }

//! HTTP Put Api Call.
  // Future<dynamic> put(String url,
  //     {Map<String, String>? headers,
  //     Map<String, String>? params,
  //     body,
  //     final dynamic Function(bool)? onError}) async {
  //   final bool isNetworkAvailable = await NetworkCheck().check();
  //   if (isNetworkAvailable) {
  //     try {
  //       final response = await http.put(
  //         Uri.parse(url),
  //         headers: headers,
  //         body: body,
  //       );
  //       var responseJson = json.decode(response.body.toString());
  //       responseJson.putIfAbsent("status_code", () => response.statusCode);
  //       return responseJson;
  //     } on Exception catch (_) {
  //       debugPrint('$_');
  //     }
  //   }
  //   return onError != null ? onError(isNetworkAvailable) : null;
  // }
  Future<JSON> put(
      {required String endpoint,
      dynamic body,
      final dynamic Function(bool)? onError}) async {
    final bool isNetworkAvailable = await NetworkCheck().check();
    if (isNetworkAvailable) {
      try {
        final response = await http.put(
          Uri.parse(endpoint),
          headers: await picArtHeader(),
          body: body,
        );
        var responseJson = json.decode(response.body.toString());
        responseJson.putIfAbsent("status_code", () => response.statusCode);
        return responseJson;
      } on Exception catch (_) {
        debugPrint('$_');
      }
    }
    return onError != null ? onError(isNetworkAvailable) : null;
  }

//! HTTP Delete Api Call.
  Future<dynamic> delete(
      {required String endpoint,
      // dynamic body,
      final dynamic Function(bool)? onError}) async {
    final bool isNetworkAvailable = await NetworkCheck().check();
    if (isNetworkAvailable) {
      try {
        final response = await http.delete(
          Uri.parse(endpoint),
          headers: await picArtHeader(),
          // body: body,
        );
        var responseJson = json.decode(response.body.toString());
        responseJson.putIfAbsent("status_code", () => response.statusCode);
        return responseJson;
      } on Exception catch (_) {
        debugPrint('$_');
      }
    }
    return onError != null ? onError(isNetworkAvailable) : null;
  }

  Future<Map<String, String>> picArtHeader() async {
    return {
      'X-Picsart-API-Key': 'ATK73Vt9xJfGkEm31OkE5ZA8qlTG1UTT',
      'accept': 'application/json'
    };
  }
}
