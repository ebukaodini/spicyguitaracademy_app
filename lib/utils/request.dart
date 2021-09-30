import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:spicyguitaracademy_app/utils/constants.dart';
import 'package:spicyguitaracademy_app/utils/exceptions.dart';

Future request(String uri,
    {String? method = 'GET',
    Object? body,
    Map<String, String>? headers}) async {
  try {
    var response;
    switch (method) {
      case 'GET':
        response = await http.get(Uri.parse(baseUrl + uri), headers: headers);
        break;
      case 'POST':
        response = await http.post(Uri.parse(baseUrl + uri),
            headers: headers, body: body);
        break;
      case 'PATCH':
        response = await http.patch(Uri.parse(baseUrl + uri),
            headers: headers, body: body);
        break;
      case 'PUT':
        response = await http.put(Uri.parse(baseUrl + uri),
            headers: headers, body: body);
        break;
      case 'DELETE':
        response =
            await http.delete(Uri.parse(baseUrl + uri), headers: headers);
        break;
      default:
        response = await http.get(Uri.parse(baseUrl + uri), headers: headers);
        break;
    }

    print("\n\n" + "Body " + body.toString());
    print("\n\n" + method! + " " + uri + " => " + response.body + "\n\n");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      switch (response.statusCode) {
        case 401:
          throw AuthException("Session Timed Out");
        case 403:
          throw AuthException("Authorization Failed");
        case 500:
          throw Exception("Server Error");
        default:
          throw Exception("Unknown Error");
      }
    }
  } on SocketException catch (e) {
    print(e);
    throw Exception("Network Error");
  } catch (e) {
    throw Exception(e);
  }
}
