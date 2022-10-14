import 'package:get/get.dart';
import 'package:techassignmsdynamics/model/UserAccount.dart';

class DetailController extends GetxController {
  var isDataLoading = false.obs;
  var userDetail = UserAccount().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    userDetail.value = Get.arguments['UserInfo'] ?? UserAccount();
    userDetail.refresh();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}
}
