import 'dart:convert';
import 'dart:developer';


import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techassignmsdynamics/Network/ApiClient.dart';
import 'package:techassignmsdynamics/Network/AuthorizationInterceptor.dart';
import 'package:techassignmsdynamics/constant/constants.dart';
import 'package:techassignmsdynamics/model/Account.dart';
import 'package:techassignmsdynamics/model/UserAccount.dart';
import 'package:dio/dio.dart' as dio;

class DataController extends GetxController {

  var isDataLoading = false.obs;
  var isGridView = false.obs;
  //final navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  var token = "".obs;
  //var lstAccounts = Account.obs;
  Account? lstAccounts;
  //List<UserAccount> foundUsers = [];
  var foundUsers = <UserAccount>[].obs;
  ApiClient? apiClient;

  Future<String?> InitializeForToken() async {
    final Config config = Config(
      tenant: 'f4ad8761-f5a5-4fc3-a697-8a4871b7a7f3',
      clientId: '51f81489-12ee-4a9e-aaae-a2591f45987d',
      scope: 'https://org9d7013e1.api.crm4.dynamics.com/user_impersonation',
      redirectUri: 'https://localhost',
      navigatorKey: navigatorKey,
    );

    final AadOAuth oauth = AadOAuth(config);
    await oauth.login();
    token.value = await oauth.getAccessToken().toString();
    log(oauth.getAccessToken().toString());
    await login(config);
    return token.value;
  }

  InitializeDio() {
    apiClient =
    ApiClient(Dio(
      BaseOptions(
        baseUrl: Constants.Base_URL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        responseType: ResponseType.json,
      ),
    )..interceptors.add(AuthorizationInterceptor()));
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await InitializeForToken();
    await InitializeDio();
    await LoadAccounts();

  }

  Future<String?> login(Config config) async {
    try {
      final AadOAuth oauth = AadOAuth(config);
      await oauth.login();
      String? accessToken = await oauth.getAccessToken();
      token.value = accessToken!;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Token', accessToken);
      print(accessToken);
      return accessToken;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<Account?>? LoadAccounts() async {
    isDataLoading(true);
    ApiClient apiClient =
        ApiClient(Dio(
          BaseOptions(
            baseUrl: Constants.Base_URL,
            connectTimeout: 5000,
            receiveTimeout: 3000,
            responseType: ResponseType.json,
          ),
        )..interceptors.add(AuthorizationInterceptor()));
    await apiClient.getAccounts("\$select=name,accountnumber,address1_stateorprovince,emailaddress1,crfaf_picture_url,crfaf_statecode,statecode").then((Data) {
      if (Data != null) {
        lstAccounts = Data;
        foundUsers.value =  lstAccounts!.lstuseraccount!;
      } else {
        //lstAccounts = [];
      }
      isDataLoading(false);
      return lstAccounts;
      //lstAccounts.refresh();
    }).catchError((Error) {
      print(Error);
      //lstAccounts.value = [];
      //lstAccounts.refresh();
      //EasyLoading.dismiss();
      //Utilities().CatchError(Error);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  FilterAccounts() async {

    ApiClient apiClient =
    ApiClient(Dio(
      BaseOptions(
        baseUrl: Constants.Base_URL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        responseType: ResponseType.json,
      ),
    )..interceptors.add(AuthorizationInterceptor()));

    await apiClient.getAccounts("\$select=name,accountnumber,address1_stateorprovince,emailaddress1,crfaf_picture_url,crfaf_statecode,statecode").then((Data) {
      if (Data != null) {
        lstAccounts = Data;
        foundUsers.value =  lstAccounts!.lstuseraccount!;
      } else {
        //lstAccounts = [];
      }
      isDataLoading(false);
      //lstAccounts.refresh();
    }).catchError((Error) {
      print(Error);
      //lstAccounts.value = [];
      //lstAccounts.refresh();
      //EasyLoading.dismiss();
      //Utilities().CatchError(Error);
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Future<void> runFilter(String enteredKeyword) async {
    //isDataLoading(true);
    ApiClient apiClient =
    ApiClient(Dio(
      BaseOptions(
        baseUrl: Constants.Base_URL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        responseType: ResponseType.json,
      ),
    )..interceptors.add(AuthorizationInterceptor()));

    List<UserAccount> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      //results = lstAccounts!.lstuseraccount!;
      await apiClient.getAccounts("\$select=name,accountnumber,address1_stateorprovince,emailaddress1,crfaf_picture_url,crfaf_statecode,statecode").then((Data) {
        if (Data != null) {
          lstAccounts = Data;
          results = lstAccounts!.lstuseraccount!;
        } else {
          //lstAccounts = [];
        }
        //lstAccounts.refresh();
      }).catchError((Error) {
        print(Error);

      }).onError((error, stackTrace) {
        print(error);
      });
    } else {
      await apiClient.getAccounts("\$select=name,accountnumber,statecode,address1_stateorprovince,entityimage_url,emailaddress1,statecode&\$filter=(contains(accountnumber,'$enteredKeyword') or contains(name,'$enteredKeyword'))").then((Data) {
        if (Data != null) {
          lstAccounts = Data;
          results = lstAccounts!.lstuseraccount!;
        } else {
          //lstAccounts = [];
        }
        //lstAccounts.refresh();
      }).catchError((Error) {
        print(Error);

      }).onError((error, stackTrace) {
        print(error);
      });
    }

    foundUsers.clear();
    foundUsers.value = results;
    foundUsers.refresh();
    isDataLoading(false);

  }

  FilterStateProvince(int i) async {
    isDataLoading(true);
    ApiClient apiClient =
    ApiClient(Dio(
      BaseOptions(
        baseUrl: Constants.Base_URL,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        responseType: ResponseType.json,
      ),
    )..interceptors.add(AuthorizationInterceptor()));

    i == 1 ?
    await apiClient.getAccounts("\$select=name,accountnumber,address1_stateorprovince,emailaddress1,crfaf_picture_url,crfaf_statecode,statecode&\$filter=statecode eq 0").then((Data) {
      if (Data != null) {
        foundUsers.clear();
        lstAccounts = Data;
        foundUsers.value =  lstAccounts!.lstuseraccount!;
        foundUsers.refresh();
      } else {
        //lstAccounts = [];
      }
      isDataLoading(false);
      //lstAccounts.refresh();
    }).catchError((Error) {
      print(Error);
    }).onError((error, stackTrace) {
      print(error);
    }) : await apiClient.getAccounts("\$select=name,accountnumber,address1_stateorprovince,emailaddress1,crfaf_picture_url,crfaf_statecode,statecode&\$filter=address1_stateorprovince ne null").then((Data) {
      if (Data != null) {
        foundUsers.clear();
        lstAccounts = Data;
        foundUsers.value =  lstAccounts!.lstuseraccount!;
        foundUsers.refresh();
      } else {
        //lstAccounts = [];
      }
      isDataLoading(false);
      //lstAccounts.refresh();
    }).catchError((Error) {
      print(Error);
    }).onError((error, stackTrace) {
      print(error);
    });

  }
}
