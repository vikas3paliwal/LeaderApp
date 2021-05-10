import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api-response.dart';
import 'http_exception.dart';
import 'api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHelper {
  final String _userIDStorageKey = 'USER_ID';
  final String _authTokenStorageKey = 'AUTH_TOKEN';
  final String _baseUrl = 'www.homeplanify.com'; //'36eb00ef8692.ngrok.io'

  static String _authToken;
  static String _userID;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static ApiHelper _instance;
  factory ApiHelper() => _instance ?? ApiHelper._internal();
  ApiHelper._internal();

  Future<String> getAuthToken() async {
    if (_authToken != null) return _authToken;

    final SharedPreferences prefs = await _prefs;
    _authToken = prefs.getString(_authTokenStorageKey) ?? '';
    return _authToken;
  }

  Future<void> _setAuthToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    _authToken = token;
    prefs.setString(_authTokenStorageKey, token);
  }

  String getAuth() {
    return _authToken;
  }

  String getURL() {
    return _baseUrl;
  }

  String getUID() {
    return _userID;
  }

  Future<void> _setUID(String uID) async {
    final SharedPreferences prefs = await _prefs;
    _userID = uID;
    //print('called: $_userID');
    prefs.setString(_userIDStorageKey, uID);
  }

  //Authentication

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await _prefs;
    final token = prefs.getString(_authTokenStorageKey) ?? '';

    if (token.isNotEmpty) {
      _authToken = token;
      _userID = prefs.getString(_userIDStorageKey) ?? '';
    }
    return token.isNotEmpty;
  }

  Future<void> SignUp(Map data) async {
    var responseBody = json.decode('{"data": "", "status": "NOK"}');

    try {
//      final url = '$_baseUrl$eLogIn';
      final uri = Uri.https(_baseUrl, eSignUp);
      print(uri);
      final response = await http.post(uri, body: data);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('201 ran');
        responseBody = jsonDecode(response.body);
        //print(responseBody);
        await _setAuthToken(responseBody['key']);
        await _setUID(responseBody['user'].toString());
        //print('uID is: $_userID');
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);

        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            // print(error);
          } else {
            error = data[key][0];
            // print(error);
            // print(data);
          }
        });
        throw HttpException(message: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      throw e;
    }
  }

  Future<void> logIn(Map data) async {
    var responseBody = json.decode('{"data": "", "status": "NOK"}');

    try {
//      final url = '$_baseUrl$eLogIn';
      final uri = Uri.https(_baseUrl, eLogIn);
      // print(uri);
      final response = await http.post(uri, body: data);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print('200 ran');
        responseBody = jsonDecode(response.body);
        //print(responseBody);
        await _setAuthToken(responseBody['key']);
        await _setUID(responseBody['user'].toString());
        //print('uID is: $_userID');
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);

        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        throw HttpException(message: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      throw e;
    }
  }

  Future<void> googleLogIn(Map data, String endpoint) async {
    var responseBody = json.decode('{"data": "", "status": "NOK"}');

    try {
//      final url = '$_baseUrl$eLogIn';
      final uri = Uri.https(_baseUrl, endpoint);
      print(uri);
      final response = await http.post(uri, body: data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        // print('200 ran');
        responseBody = jsonDecode(response.body);
        //print(responseBody);
        await _setAuthToken(responseBody['key']);
        await _setUID(responseBody['user'].toString());
        //print('uID is: $_userID');
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);

        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        throw HttpException(message: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      throw e;
    }
  }

  Future<void> logOut() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    try {
      ApiResponse response = await postRequest('/rest-auth/logout/', {});
    } catch (e) {
      print(e.toString() + 'line 152');
    }

    _userID = null;
    _authToken = null;
  }

  //GET
  Future<ApiResponse> getRequest(
      {String endpoint, Map<String, String> query}) async {
    if (_authToken.isEmpty || _authToken == null) {
      print('not logged in');
      return ApiResponse(error: true, errorMessage: 'User not logged in');
    }
    try {
      //final url = '$_baseUrl$endpoint';
      final uri = Uri.https(_baseUrl, endpoint, query);
      print(uri);
      print(_authToken);
      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Token $_authToken',
        },
      );

      if (response.statusCode == 206 ||
          response.statusCode == 201 ||
          response.statusCode == 204 ||
          response.statusCode == 200 ||
          response.statusCode == 202 ||
          response.statusCode == 203 ||
          response.statusCode == 205 ||
          response.statusCode == 207) {
        print('==');
        return ApiResponse(data: jsonDecode(response.body));
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      print('socket');
      throw HttpException(message: 'No Internet Connection');
    } on PlatformException catch (error) {
      print('plt');
      throw HttpException(message: 'platform');
    } catch (e) {
      throw e;
    }
  }

  //GET Without Auth
  Future<ApiResponse> getWithoutAuthRequest(
      {String endpoint, Map<String, String> query}) async {
    try {
      //final url = '$_baseUrl$endpoint';
      final uri = Uri.https(_baseUrl, endpoint, query);
      print(uri);
      final response = await http.get(
        uri,
      );

      if (response.statusCode == 200) {
        return ApiResponse(data: jsonDecode(response.body));
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse> forgotpass(
      String endpoint, Map<String, dynamic> data) async {
    try {
//      final url = '$_baseUrl$endpoint';
      final uri = Uri.https(_baseUrl, endpoint);
      print(jsonEncode(data));
      final response = await http.post(uri, body: data);
      print('code is ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('++++');
        print(response.body);
        return ApiResponse(data: jsonDecode(response.body));
      } else {
        print(response.body);
        print(response.statusCode);
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          } else {
            error = data[key][0];
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      print('socket');
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      print('***********');
      print(e);
      throw e;
    }
  }

  //POST
  Future<ApiResponse> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    print('post');
    print(_authToken + 'line');
    if (_authToken.isEmpty || _authToken == null) {
      return ApiResponse(error: true, errorMessage: 'User not logged in');
    }
    try {
//      final url = '$_baseUrl$endpoint';
      final uri = Uri.https(_baseUrl, endpoint);
      print(jsonEncode(data));
      final response = await http.post(uri,
          headers: {
            HttpHeaders.authorizationHeader: 'Token $_authToken',
          },
          body: data);
      print('code is ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('++++');
        print(response.body);
        return ApiResponse(data: jsonDecode(response.body));
      } else {
        print(response.body);
        print(response.statusCode);
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          } else {
            error = data[key][0];
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      print('socket');
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      print('***********');
      print(e);
      throw e;
    }
  }

  // PUT
  Future<ApiResponse> patchRequest(
      String endpoint, Map<String, dynamic> data) async {
    if (_authToken.isEmpty || _authToken == null) {
      return ApiResponse(error: true, errorMessage: 'User not logged in');
    }
    try {
      final url = '$_baseUrl$endpoint';
      final uri = Uri.https(_baseUrl, endpoint);

      final response = await http.patch(uri,
          headers: {
            HttpHeaders.authorizationHeader: 'Token $_authToken',
          },
          body: data);
      print('code is ${response.statusCode}');
      print('++++');
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(data: jsonDecode(response.body));
      } else {
        print(response.body);
        print(response.statusCode);
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //PATCH WITH FIILE
  Future<ApiResponse> patchRequestwithFile(
      {String endpoint, var data, File file, String fileFieldName}) async {
    if (_authToken.isEmpty || _authToken == null) {
      return ApiResponse(error: true, errorMessage: 'User not logged in');
    }
    try {
      http.Response response;
      final uri = Uri.https(_baseUrl, endpoint);
      print(uri);

      // multipart that takes file
      if (file != null) {
        Map<String, String> headers = {
          HttpHeaders.authorizationHeader: 'Token $_authToken',
          HttpHeaders.contentTypeHeader: 'multipart/form-data',
        };
        var request = new http.MultipartRequest("PATCH", uri);
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath(fileFieldName, file.path);
        request.files.add(multipartFile);
        request.headers.addAll(headers);
//        print(file.path);
        data.forEach((key, value) {
          request.fields[key] = value;
          print(request.fields.toString());
        });
        final streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
        // add file to multipart
      } else {
        Map<String, String> headers = {
          HttpHeaders.authorizationHeader: 'Token $_authToken',
        };
        response = await http.patch(uri, headers: headers, body: data);
      }
//      print('code is ${response.statusCode}');
      if (response.statusCode == 200) {
        print('response is: ${jsonDecode(response.body)}');
        return ApiResponse(data: jsonDecode(response.body));
      } else {
        print('error occurred: ${response.body}');
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      throw e;
    }
  }

  //POST WITH FILE
  Future<ApiResponse> postWithFileRequest(
      {String endpoint, var data, File file, String fileFieldName}) async {
    if (_authToken.isEmpty || _authToken == null) {
      return ApiResponse(error: true, errorMessage: 'User not logged in');
    }
    try {
      http.Response response;
      final uri = Uri.https(_baseUrl, endpoint);
      print(uri);

      // multipart that takes file
      if (file != null) {
        Map<String, String> headers = {
          HttpHeaders.authorizationHeader: 'Token $_authToken',
          HttpHeaders.contentTypeHeader: 'multipart/form-data'
        };
        var request = new http.MultipartRequest("POST", uri);
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath(fileFieldName, file.path);
        request.files.add(multipartFile);
        request.headers.addAll(headers);

        data.forEach((key, value) {
          request.fields[key] = value.toString();
          print(request.fields.toString());
        });
        final streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
        // add file to multipart
      } else {
        Map<String, String> headers = {
          HttpHeaders.authorizationHeader: 'Token $_authToken',
        };
        response = await http.patch(uri, headers: headers, body: data);
      }
//      print('code is ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('response is: ${jsonDecode(response.body)}');
        return ApiResponse(data: jsonDecode(response.body));
      } else {
        print('error occurred: ${response.statusCode}: ${response.body}');
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      throw e;
    }
  }

  // DELETE
  Future<ApiResponse> deleteRequest({String endpoint, String id}) async {
    if (_authToken.isEmpty || _authToken == null) {
      print('not logged in');
      return ApiResponse(error: true, errorMessage: 'User not logged in');
    }
    try {
      //final url = '$_baseUrl$endpoint';
      final String endPointUrl = id == null ? endpoint : '$endpoint/' + '$id/';
      print(endPointUrl);
      final uri = Uri.https(_baseUrl, endPointUrl);
      print(uri);
      final response = await http.delete(
        uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Token $_authToken',
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body != null)
          return ApiResponse(data: jsonDecode(response.body));
        return ApiResponse(data: 'Success Code 200');
      } else {
        print(response.body);
        print(response.statusCode);
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      throw e;
    }
  }
}
