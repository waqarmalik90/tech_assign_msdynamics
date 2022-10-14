import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:techassignmsdynamics/constant/route_constant.dart';
import 'package:techassignmsdynamics/ui/binding/detail_binding.dart';
import 'package:techassignmsdynamics/ui/binding/home_binding.dart';
import 'package:techassignmsdynamics/ui/view/detail_screen.dart';
import 'package:techassignmsdynamics/ui/view/home_screen.dart';

List<GetPage> getPages = [
  GetPage(
      name: RouteConstant.homeScreen,
      page: () =>  HomeScreen(),
      middlewares:  [
        // Add here
        // AuthGuard(),
      ],
      binding: HomeScreenBinding()),
  GetPage(
      name: RouteConstant.detailScreen,
      page: () =>  DetailScreen(),
      middlewares:  [
        // Add here
        // AuthGuard(),
      ],
      binding: DetailScreenBinding())
];