abstract class BaseApiServices {
  Future<dynamic> getApiRequest(String url);
  Future<dynamic> postApiRequest(dynamic data, String url);
}
