part of 'remote_imports.dart';

class ApiClient {
  late BaseOptions baseOptions;
  late Dio dio;
  Options options = Options();

  ApiClient() {
    baseOptions = BaseOptions(baseUrl: ApiConstant.baseUrl);
    dio = Dio(baseOptions);
    options = Options(
        headers: {'Authorization': 'Bearer ${ApiConstant.accessToken}'});
    // dio.interceptors.add(PrettyDioLogger());
  }

  Future<Response> getRequest(
      {required String path, bool isTokenRequired = false}) async {
    try {
      Response response = await dio.get(path, options: options);
      debugPrint('\n\nURL: ${ApiConstant.baseUrl}$path');
      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint(
          'RESPONSE: ${response.data.toString().substring(0, 1000)}\n\n');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException(message: e.response?.statusMessage);
      } else {
        throw ApiException(message: e.message);
      }
    } catch (error) {
      throw ApiException(message: error.toString());
    }
  }

  Future<Response> postRequest(
      {required String path,
      Map<String, dynamic>? body,
      bool isTokenRequired = false}) async {
    try {
      Response response = await dio.post(path, data: body, options: options);
      debugPrint('\n\nURL: ${ApiConstant.baseUrl}$path');
      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('RESPONSE: ${response.data.toString().substring(0, 500)}\n\n');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException(message: e.response?.statusMessage);
      } else {
        throw ApiException(message: e.message);
      }
    }
  }
}
