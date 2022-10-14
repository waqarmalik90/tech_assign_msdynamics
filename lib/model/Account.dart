import 'package:techassignmsdynamics/model/UserAccount.dart';

class Account {
   List<UserAccount>? lstuseraccount;

  Account({
  this.lstuseraccount,
  });

  Account.fromJson(Map<String, dynamic> json) {
    lstuseraccount = (json['value'] as List?)?.map((dynamic e) => UserAccount.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['value'] = lstuseraccount?.map((e) => e.toJson()).toList();
    return json;
    }
}

class Value {
  String? name;
  String? accountnumber;
  String? address1Stateorprovince;
  dynamic emailaddress1;
  String? crfafPictureUrl;
  String? crfafStatecode;
  String? accountid;
  String? address1Composite;

  Value({
  this.name,
  this.accountnumber,
  this.address1Stateorprovince,
  this.emailaddress1,
  this.crfafPictureUrl,
  this.crfafStatecode,
  this.accountid,
  this.address1Composite,
  });

  Value.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    accountnumber = json['accountnumber'] as String?;
    address1Stateorprovince = json['address1_stateorprovince'] as String?;
    emailaddress1 = json['emailaddress1'];
    crfafPictureUrl = json['crfaf_picture_url'] as String?;
    crfafStatecode = json['crfaf_statecode'] as String?;
    accountid = json['accountid'] as String?;
    address1Composite = json['address1_composite'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['accountnumber'] = accountnumber;
    json['address1_stateorprovince'] = address1Stateorprovince;
    json['emailaddress1'] = emailaddress1;
    json['crfaf_picture_url'] = crfafPictureUrl;
    json['crfaf_statecode'] = crfafStatecode;
    json['accountid'] = accountid;
    json['address1_composite'] = address1Composite;
    return json;
  }
}