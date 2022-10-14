import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:techassignmsdynamics/Network/ApiClient.dart';
import 'package:techassignmsdynamics/model/Account.dart';
import 'package:techassignmsdynamics/ui/controller/home_controller.dart';
import 'package:techassignmsdynamics/ui/view/home_screen.dart';

import 'unit_test.mocks.dart';

@GenerateMocks([ApiClient])
void main(){
  group("Home Screen Controller", () {
    test("Initialization of Empty List of Accounts List", () {

      DataController dataController = DataController();

      expect(dataController.foundUsers.toList().length, 0);
    });

    test("Account Data Added in foundList", () {

      DataController dataController = DataController();
      dataController.LoadAccounts();

      expect(dataController.foundUsers.toList().length, 5);
    });

    test("Get Accounts Table Data into our Model", () async {
      DataController dataController = DataController();
      late ApiClient apiClient;
    
      apiClient = MockApiClient();
     
      File apiFile = File('test/ApiResponse/accountsData.json');
      final jsonMap = jsonDecode(apiFile.readAsStringSync()) as Map<String, dynamic>;

      when(dataController.InitializeDio().LoadAccounts()).thenAnswer((_) async =>
          Future.value(
            Account.fromJson(jsonMap),
          ),
      );

      final result = await apiClient.getAccounts("\$select=name,accountnumber,statecode,address1_stateorprovince,entityimage_url,emailaddress1");

      expect(result, equals(Account.fromJson(jsonMap)));


    });

    test("Get MSAF token",() async{
      DataController dataController = DataController();
      File tokenFile = File('test/ApiResponse/token.json');
      final jsonMap = jsonDecode(tokenFile.readAsStringSync()) as Map<String, dynamic>;

      when(dataController.InitializeForToken()).thenAnswer((_) async  {
        return jsonMap['token'];
      });

      //final result = String? token;

      expect(String, equals(jsonMap['access_token']));
    });

    //WidgetTest
    testWidgets('Find 1 ListView Widget in Home Screen and return true in case of one',
            (WidgetTester tester) async {
          await tester.pumpWidget(const HomeScreen());
          expect(find.byType(ListView), findsOneWidget); // Expecting 1 List Screen.
        });

    /*testWidgets('Find 1 ListView Widget in Home Screen and return true in case of one',
            (WidgetTester tester) async {
          await tester.pumpWidget(const HomeScreen());
          expect(find.byWidget(), findsNWidgets(1)); // Expecting 1 List Screen.
        });*/



  });

}
