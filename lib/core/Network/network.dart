import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:news/core/Errors/failure.dart';
import 'package:news/core/utils/constant.dart';
import 'package:news/core/utils/parser.dart';

/// An abstract class defining methods for network-related operations.
abstract class NetworkService {
  /// A future that returns `true` if the device is connected to the internet, and `false` otherwise.
  Future<bool> get isConnected;

  /// A method for making GET requests to a remote endpoint.
  /// Returns a tuple of [Failure?, ApiResponseModel?].
  Future<(Failure?, Map<String, dynamic>?)> get(
      {required String endpoint,
      Map<String, String>? headers,
      Map<String, String>? query});

  /// A method for making POST requests to a remote endpoint.
  /// Returns a tuple of [Failure?, ApiResponseModel?].
  Future<(Failure?, Map<String, dynamic>?)> post(
      {required String endpoint,
      Map<String, String>? headers,
      required Map<String, String> data});
}

/// An implementation of the [NetworkService] class.
class NetworkServiceImpl extends NetworkService with Parser {
  final InternetConnectionCheckerPlus connectionChecker;
  final APIInfo apiInfo;

  /// Constructor for [NetworkServiceImpl].
  NetworkServiceImpl(this.connectionChecker, this.apiInfo);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Future<(Failure?, Map<String, dynamic>?)> get(
      {required String endpoint,
      Map<String, String>? headers,
      Map<String, String>? query}) async {
    if (await isConnected) {
      headers ??= apiInfo.defaultHeader;
      final uri = Uri.parse(_buildUrl(endpoint));
      final response = await http.get(uri, headers: headers);
      print(response.body.toString());
      return _processResponse(response);
    }
    return (const InternetConnectionFailure(), null);
  }

  @override
  Future<(Failure?, Map<String, dynamic>?)> post(
      {required String endpoint,
      Map<String, String>? headers,
      required Map<String, String> data}) async {
    if (await isConnected) {
      headers ??= apiInfo.defaultHeader;
      final uri = Uri.parse(_buildUrl(endpoint));
      final encodedData = jsonToString(data);
      if (encodedData.$1 != null) {
        return (const JsonEncodeFailure(), null);
      }
      final response = await http.post(uri, headers: headers, body: data);
      return _processResponse(response);
    }
    return (const InternetConnectionFailure(), null);
  }

  String _buildUrl(String endpoint) =>
      apiInfo.getBaseUrl() +
      apiInfo.subBaseUrl() +
      apiInfo.apiVersion() +
      endpoint;

  (Failure?, Map<String, dynamic>?) _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      final decodedResponse = stringToJson(response.body.toString());
      if (decodedResponse.$1 != null) {
        return (decodedResponse.$1, null);
      }
    }
    return (const EndpointFailure(), null);
  }
}
