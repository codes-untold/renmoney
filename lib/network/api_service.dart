import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/io_client.dart' as inner;
import 'package:renmoney/network/api_routes.dart';
import 'package:renmoney/utilities/constants.dart';
import 'package:renmoney/utilities/services.dart';

class ApiRequestOptions {
  final bool showMsg;
  final int? timeout;
  final bool useBaseUrl;
  final bool useGeneralErrorHandler;
  Map<String, String>? headers;

  ApiRequestOptions(
      {this.showMsg = false,
      this.timeout = 60,
      this.useBaseUrl = true,
      this.useGeneralErrorHandler = true,
      this.headers});
}

class ApiResponse<T> {
  T? data;
  String? code;
  String? message;
  String? status;

  ApiResponse({this.code, this.status, this.data, this.message});
}

class ApiService {
  static String toQueryString(Map<String, String> map) =>
      map.entries.map((e) => '${e.key}=${e.value}').join('&');

  static Future<ApiResponse<T>> apiRequest<T>(
      String type, String url, dynamic body,
      {Map<String, String>? queryParams,
      ApiRequestOptions? options,
      Function? converter}) async {
    //......
    //......
    Response response;
    try {
      final inner.IOClient _client = getClient();
      final Duration timeout = Duration(seconds: options?.timeout ?? 60);
      Map<String, String> headers = {};

      // fetch auth_token from storage
      String authToken = Constants.userToken;

      //append headers(sourceappid & user token)
      headers[HttpHeaders.authorizationHeader] = "Bearer " + authToken;
      headers["sourceappid"] = "ckpu7zo0p0000gg5436coo7xs";

      Uri uri = Uri.parse(url);

      response = await _client.get(uri, headers: headers).timeout(timeout);

      _client.close();

      // implement a logger library to abstract logs, forward them and control based on build environment
      print("API response :: " +
          response.statusCode.toString() +
          " --> " +
          response.body.toString());

      var decodedRsp = json.decode(response.body.toString());

      var data = decodedRsp["data"];

      ApiResponse<T> rsp = ApiResponse(
          code: decodedRsp["code"],
          data: data == null ? null : converter!(data),
          message: decodedRsp["message"].toString(),
          status: decodedRsp["status"]);

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created ||
          response.statusCode == HttpStatus.accepted) {
      } else if (response.statusCode == HttpStatus.badRequest) {
        if (options?.showMsg == true) {
          // display generic success message from api
          //toast(msg);
        }
      } else if (response.statusCode == HttpStatus.unauthorized) {
        TransactionService().showTopToast("user not authorized");
      } else if (response.statusCode == HttpStatus.forbidden) {
        // display toast or modal
      } else if (response.statusCode == HttpStatus.notFound) {
        TransactionService().showTopToast("resource not found");
      }

      return rsp;
    } catch (e) {
      print(e); // handle from generic logger

      if (options?.useGeneralErrorHandler == true) {
        // display error msg from server, else a generic server error msg
        // "Oops! Something went wrong.."
        return Future.value(
            ApiResponse<T>()); // remove this line after handling with modal
      } else {
        TransactionService().showTopToast(e.toString());
        return Future.error(e);
      }
    }
  }

  static Future<ApiResponse<T>> get<T>(String url,
      {Map<String, String>? queryParams,
      ApiRequestOptions? options,
      Function? converter}) async {
    return await apiRequest<T>("get", url, null,
        queryParams: queryParams, options: options, converter: converter);
  }

  static inner.IOClient getClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    inner.IOClient ioClient = inner.IOClient(httpClient);
    return ioClient;
  }
}
