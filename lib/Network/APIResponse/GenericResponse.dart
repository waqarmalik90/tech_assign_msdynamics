class GenericResponse {
  String applicationTrackingNo;
  int ApplicationID;

  GenericResponse({this.applicationTrackingNo = "", this.ApplicationID = 0});

  GenericResponse.fromJson(Map json)
      : applicationTrackingNo = json["applicationTrackingNo"] != null
            ? json["applicationTrackingNo"]
            : "",
        ApplicationID =
            json["applicationId"] != null ? json["applicationId"] : 0;

  toJson() {
    return {
      'applicationTrackingNo': applicationTrackingNo,
      'applicationId': ApplicationID
    };
  }
}
