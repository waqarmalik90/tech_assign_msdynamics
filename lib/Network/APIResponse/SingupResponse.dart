class SignupResponse {
  int CitizenID;
  String UserName;
  String? Message;
  String? Password;

  SignupResponse(
      {this.CitizenID = 0,
      this.UserName = "",
      this.Message = "",
      this.Password});

  SignupResponse.fromJson(Map json)
      : CitizenID = json["citizenId"],
        UserName = json["userName"],
        Message = json["message"],
        Password = json["password"];

  toJson() {
    return {
      'citizenId': CitizenID,
      'username': UserName,
      'message': Message,
      'password': Password
    };
  }
}
