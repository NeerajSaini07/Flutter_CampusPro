abstract class BaseApiServices {
  Future<dynamic> getApiRequest(String url);
  Future<dynamic> postApiRequest(dynamic data, String url);
  Future<dynamic> postFileRequest(
      Map<String, String> fields, String key, String filePath, String url);
}
