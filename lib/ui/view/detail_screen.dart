import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techassignmsdynamics/constant/constants.dart';
import 'package:techassignmsdynamics/ui/controller/detail_controller.dart';
import 'package:techassignmsdynamics/ui/controller/home_controller.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DetailController detailController = Get.put(DetailController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: const Text('Tech Assign Dynamics',),
        centerTitle: true,),
        body: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(detailController.userDetail.value.crfafPictureUrl != null ?
              Constants.Base_URL + detailController.userDetail.value.crfafPictureUrl!
                  : ""),
            ),

            Card(
              color: Colors.grey[100],
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Text(
                            "Account Number:",
                          ),
                          Text(detailController.userDetail.value.accountnumber ?? ""),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Text(
                            "Account Name:",
                          ),
                          Text(detailController.userDetail.value.name ?? ""),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Text(
                            "Address:",
                          ),
                          Text(detailController.userDetail.value.address1Composite ?? ""),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Text(
                            "Email:",
                          ),
                          Text(detailController.userDetail.value.emailaddress1 ?? ""),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
