import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

class HttpProvider {
  Future<http.Response> getClient(String endpoint) async {
    try {
      final String url =
          '${GlobalConfiguration().getValue('api_base_url')}$endpoint';

      final client = http.Client();

      final response = await client.get(Uri.parse(url));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

//Sample for put
  Future<http.Response> put(String endpoint) async {
    try {
      final String url =
          '${GlobalConfiguration().getValue('api_base_url')}$endpoint';

      final client = http.Client();

      //// this is a sample code if this app used any API tokens
      //// you could fetch it from local storage
      /* final token = LocalStorage.getToken(); */

      final response = await client.put(
        Uri.parse(url),

        //// Sample code if this app needed any headers, you'd send it them here
        /* headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }, */
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

//Sample code for if you needed to fetch anything by sending
//your whole API url other than the base url you use
  Future<http.Response> getClientNoBaseUrl(String url) async {
    try {
      final client = http.Client();

      final response = await client.get(
        Uri.parse(url),
      );

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

//Sample for post
  Future<http.Response> post(String endpoint) async {
    try {
      final String url =
          '${GlobalConfiguration().getValue('api_base_url')}$endpoint';
      final client = http.Client();

      final response = await client.post(Uri.parse(url));

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

//// Sample for getting http StreamedResponse
  Future<http.StreamedResponse> getStream(String endpoint) async {
    try {
      final String url =
          '${GlobalConfiguration().getValue('api_base_url')}$endpoint';

      //// Sample code for working with tokens
      /* final token = LocalStorage.getToken();
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }; */
      var request = http.Request('GET', Uri.parse(url));

      //// Sample code for working with headers
      /* request.headers.addAll(headers); */

      http.StreamedResponse response = await request.send();
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}

final HttpProvider httpProvider = HttpProvider();
