# Flutter App Using Microsoft Dynamics CRM with MSAL Token Authentication

## Description

The purpose of this application to use Microsoft Dynamics CRM Accounts Table which is hosted on Microsoft Azure through a Web API. MSAL (Microsoft Authentication Library) token was used to make the Dynamics CRM API Call.

## Packages Used

1. [GetX](https://pub.dev/packages/get) Architecture for state and routes management.
2. [Dio](https://pub.dev/packages/dio) for API Calling.
3. [Retrofit](https://pub.dev/packages/retrofit) for consuming MS Dynamic Web API.
5. [aad_oauth](https://pub.dev/packages/aad_oauth) for performing user authentication against Azure    Active Directory OAuth2 v2.0 endpoint.
6. [dropdown_button2](https://pub.dev/packages/dropdown_button2) for using dropdown.
7. [Mockito](https://pub.dev/packages/mockito) for API client mocks test.


## Setting up Environment to get Access Token for Application

1. Go to this [Link](https://signup.microsoft.com/get-started/signup?ali=1&products=5a589020-9713-4df5-a155-8761fbb7e419&ru=https%3A%2F%2Fadmin.powerplatform.microsoft.com%2Fenvironments%3Fopen%3Dnew%26type%3DTrial%26template%3DD365_FieldServicePremiumTrial) and setup Microsoft Dynamics Account.
2. Set up your environment in power app using this [Link](https://admin.powerplatform.microsoft.com/environments).
3. Connect your Microsoft dynamics CRM with Azure using this [Link](https://portal.azure.com/).
4. Change the base url of the application in constants.dart file with your relevant url.
5. Changes in the following code snipped in home_controller.dart class with your generated keys.



```dart
Future<String?> InitializeForToken() async {
    final Config config = Config(
      tenant: 'f4ad8761-f5a5-4fc3-a697-8a4871b7a7f3',
      clientId: '51f81489-12ee-4a9e-aaae-a2591f45987d',
      scope: 'https://org9d7013e1.api.crm4.dynamics.com/user_impersonation',
      redirectUri: 'https://localhost',
      navigatorKey: navigatorKey,
    );
```

## Demo Video



https://user-images.githubusercontent.com/27821256/195843815-c96df54a-f022-421b-970e-b76fd3b35354.mp4






## Contributing
Pull requests are welcome.
