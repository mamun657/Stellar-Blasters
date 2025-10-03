import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiHandler {
  final String baseUrl;
  final http.Client _client;

  ApiHandler(this.baseUrl) : _client = http.Client();

  /// A generalized method to handle various HTTP requests.
  /// It can handle GET, POST (JSON), and POST with file uploads.
  ///
  /// - [method]: The HTTP method (e.g., 'GET', 'POST').
  /// - [endpoint]: The API endpoint path.
  /// - [params]: Optional parameters for the request. For GET, they become
  ///   query parameters. For POST, they become the JSON body or multipart fields.
  /// - [files]: Optional list of files to upload.
  Future<Map<String, dynamic>> request({
    required String method,
    required String endpoint,
    Map<String, dynamic>? params,
    List<File>? files,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = {'Content-Type': 'application/json'};

    try {
      if (files != null && files.isNotEmpty) {
        // Handle multipart request with file uploads
        if (method.toUpperCase() != 'POST') {
          throw Exception('File uploads are only supported for POST method.');
        }
        return _handleMultipartRequest(uri, params, files);
      } else {
        // Handle standard GET/POST requests
        if (method.toUpperCase() == 'GET') {
          return _handleGetRequest(uri, params);
        } else if (method.toUpperCase() == 'POST') {
          return _handlePostRequest(uri, headers, params);
        } else {
          throw Exception('Unsupported HTTP method: $method');
        }
      }
    } catch (e) {
      // Re-throw with a more descriptive error message
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _handleGetRequest(
      Uri uri, Map<String, dynamic>? params) async {
    // Append query parameters to the URL
    final newUri = uri.replace(queryParameters: params);
    final response = await _client.get(newUri);
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> _handlePostRequest(
      Uri uri, Map<String, String> headers, Map<String, dynamic>? params) async {
    final response =
        await _client.post(uri, headers: headers, body: json.encode(params));
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> _handleMultipartRequest(
      Uri uri, Map<String, dynamic>? params, List<File> files) async {
    final request = http.MultipartRequest('POST', uri);

    // Add form fields from parameters
    if (params != null) {
      params.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }

    // Add files to the request
    for (var file in files) {
      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final multipartFile = http.MultipartFile(
        'files[]', // Use 'files[]' for a list of files on the server side
        stream,
        length,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'jpeg'), // Adjust content type as needed
      );
      request.files.add(multipartFile);
    }

    // Send the request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return _processResponse(response);
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }

  void dispose() {
    _client.close();
  }
}

// Example usage
Future<void> main() async {
  // NOTE: In a real app, you would use a real base URL.
  // This example uses a mock URL for demonstration purposes.
  final api = ApiHandler('https://api.example.com'); 
  
  try {
    // Example 1: GET request with parameters
    final getResponse = await api.request(
      method: 'GET',
      endpoint: '/users',
      params: {'id': 123, 'name': 'John Doe'},
    );
    print('GET Response: $getResponse');

    // Example 2: POST request with JSON payload
    final postResponse = await api.request(
      method: 'POST',
      endpoint: '/register',
      params: {'username': 'testuser', 'password': 'password123'},
    );
    print('POST Response: $postResponse');

    // Example 3: POST request with files (NOTE: Requires a real file path and server)
    // final file = File('/path/to/your/file.jpg');
    // final fileUploadResponse = await api.request(
    //   method: 'POST',
    //   endpoint: '/upload',
    //   files: [file],
    // );
    // print('File Upload Response: $fileUploadResponse');

  } catch (e) {
    print('An error occurred: $e');
  } finally {
    api.dispose();
  }
}