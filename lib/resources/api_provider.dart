import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import '../models/error_model.dart';
import '../models/success_model.dart';
import '../user_session.dart';

class ApiProvider {
  Client _client = Client();

  Future<Either<ErrorModel, SuccessModel>> post(
      {body,
      String? path,
      bool authorization = false,
      File? file,
        String? accessToken,
      Function? getModel}) async {
    try {
      Response response;
      if (file != null) {
        var request = MultipartRequest("POST", Uri.parse("$path"));
        request.headers[HttpHeaders.authorizationHeader] =
            authorization ? "Bearer ${UserSession.accessToken}" : "";
        request.headers[HttpHeaders.acceptHeader] = 'application/json';
        request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';
        request.files.add(await MultipartFile.fromPath('file', file.path,
            contentType: MediaType('file', file.path.split(".").last)));
        if (body != null) {
          request.fields.addAll(body);
        }
        final StreamedResponse streamResponse = await request.send();
        response = await Response.fromStream(streamResponse);
      } else {
        response = await _client.post(Uri.parse("$path"),
            body: jsonEncode(body),
            headers: {
              "content-type": "application/json",
              "accept": "application/json",
              "authorization":
                  authorization ? "Bearer ${accessToken??UserSession.accessToken}" : ""
            });
      }
      var parsedBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return right(SuccessModel(
            title: "Success",
            message: parsedBody["message"],
            data: getModel!(parsedBody["data"])));
      } else {
        return left(ErrorModel(
            message: parsedBody["message"],
            title: "Error",
            errorCode: response.statusCode));
      }
    } on SocketException {
      return left(ErrorModel(
          message: "No internet connection", title: "Error", errorCode: 400));
    } on Exception {
      return left(ErrorModel(
          message: "Something went wrong. Try again",
          title: "Error",
          errorCode: 400));
    }
  }

  Future<Either<ErrorModel, SuccessModel>> get(
      {String? path,
        String? accessToken,
      bool authorization = false,
      File? file,
      Function? getModel}) async {
    try {
      Response response =
          await _client.get(Uri.parse("$path"), headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "authorization": authorization
            ? "Bearer ${accessToken ?? UserSession.accessToken}"
            : ""
      });
      var parsedBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return right(SuccessModel(
            title: "Success",
            message: "Data is Fetched Successfully",
            data: getModel!(parsedBody)));
      } else {
        return left(ErrorModel(
            message: parsedBody["message"] ?? "Error! Something went wrong",
            title: "Error",
            errorCode: response.statusCode));
      }
    } on SocketException {
      return left(ErrorModel(
          message: "No internet connection!", title: "Error", errorCode: 400));
    } on HttpException {
      return left(ErrorModel(
          message: "Server is not responding. Try later",
          title: "Error",
          errorCode: 400));
    } on Exception {
      return left(ErrorModel(
          message: "Something went wrong. Try again",
          title: "Error",
          errorCode: 400));
    }
  }
}
