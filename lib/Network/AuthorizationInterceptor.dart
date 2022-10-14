import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techassignmsdynamics/ui/controller/home_controller.dart';

// ignore: constant_identifier_names

/*final prefs = await SharedPreferences.getInstance();
final String? action = prefs.getString('action');*/
DataController dataController = Get.put(DataController());

// Request methods PUT, POST, PATCH, DELETE needs access token,
// which needs to be passed with "Authorization" header as Bearer token.
class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_needAuthorizationHeader(options)) {
      // adds the access-token with the header
      options.headers['Authorization'] = 'Bearer ${dataController.token.value}';
      options.headers['OData-MaxVersion'] = '4.0';
      options.headers['OData-Version'] = '4.0';
    }
    // continue with the request
    super.onRequest(options, handler);
  }

  bool _needAuthorizationHeader(RequestOptions options) {
    if (options.method == 'GET') {
      return true;
    } else {
      return true;
    }
  }
}