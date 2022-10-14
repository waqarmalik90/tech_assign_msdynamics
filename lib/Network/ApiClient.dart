import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:techassignmsdynamics/constant/constants.dart';
import 'package:techassignmsdynamics/model/Account.dart';

import 'APIResponse/SingupResponse.dart';

part 'ApiClient.g.dart';

@RestApi(baseUrl: Constants.Base_URL)


abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("accounts?{query}")
  Future<Account> getAccounts(@Path("query") String query);

}
