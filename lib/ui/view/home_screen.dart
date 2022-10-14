import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techassignmsdynamics/Network/AuthorizationInterceptor.dart';
import 'package:techassignmsdynamics/constant/constants.dart';
import 'package:techassignmsdynamics/constant/route_constant.dart';
import 'package:techassignmsdynamics/model/UserAccount.dart';
import 'package:techassignmsdynamics/ui/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataController dataController = Get.put(DataController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: dataController.navigatorKey,
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Tech Assign Dynamics',),
        centerTitle: true,),
        body:
        Obx(() => dataController.isDataLoading.value == true
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => dataController.runFilter(value),
                  decoration: const InputDecoration(
                      labelText: 'Search', suffixIcon: Icon(Icons.search)),
                ),
              ),

              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  customButton: const Icon(
                    Icons.filter_list_alt,
                    size: 25,
                    color: Colors.black,
                  ),
                  customItemsHeights: [
                    ...List<double>.filled(MenuItems.firstItems.length, 48),
                  ],
                  items: [
                    ...MenuItems.firstItems.map(
                          (item) =>
                          DropdownMenuItem<MenuItem>(
                            value: item,
                            child: MenuItems.buildItem(item),
                          ),
                    ),
                  ],
                  onChanged: (value) {
                    MenuItems.onChanged(context, value as MenuItem);
                  },
                  itemHeight: 48,
                  itemPadding: const EdgeInsets.only(left: 16, right: 16),
                  dropdownWidth: 160,
                  dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  dropdownElevation: 8,
                  offset: const Offset(0, 8),
                ),
              ),
              Text("Filter"),

              /*IconButton(
              iconSize: 20,
              icon: const Icon(
                Icons.filter_list_alt,
              ),
              // the method which is called
              // when button is pressed
              onPressed: () {
                showPopupMenu();
              },
            ),
            Text("Filter"),*/

              IconButton(
                iconSize: 25,
                icon: const Icon(
                  Icons.list,
                ),
                // the method which is called
                // when button is pressed
                onPressed: () {
                  dataController.isGridView(false);
                },
              ),
              IconButton(
                iconSize: 20,
                icon: const Icon(
                  Icons.grid_view_sharp,
                ),
                // the method which is called
                // when button is pressed
                onPressed: () {
                  dataController.isGridView(true);
                },
              ),
            ],),
            const SizedBox(
              height: 20,
            ),
            dataController.isGridView.value == false ?
            Expanded(
              child: ListView.builder(
                  itemCount: dataController.foundUsers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                                RouteConstant.detailScreen,
                                arguments: {
                                  "UserInfo":
                                  dataController.foundUsers[index]
                                });
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 20,right: 20),
                              padding: const EdgeInsets.only(left: 20),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              decoration:  BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(dataController.foundUsers[index].crfafPictureUrl != null ?
                                    Constants.Base_URL + dataController.foundUsers[index].crfafPictureUrl!
                                        : ""),
                                  ),
                                  const SizedBox(width: 30,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(dataController.foundUsers[index].name!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18
                                        ),),
                                      Text(dataController.foundUsers[index].accountnumber!,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18
                                          )),
                                      Text(dataController.foundUsers[index].address1Stateorprovince!,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18
                                          )),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }),
            ) :
            Expanded(
              child:
              GridView.builder(
                  padding:
                  const EdgeInsets.all(0),
                  scrollDirection:
                  Axis.vertical,
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemCount:
                  dataController.foundUsers.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio:
                      1.5 / 2,
                      mainAxisExtent:
                      150,
                      crossAxisSpacing:
                      5,
                      mainAxisSpacing:
                      5),
                  itemBuilder:
                      (context, index) {
                    return ServiceItem(
                        context,
                        dataController.foundUsers[index],
                        index);
                  }),
            )

          ],
        ))

      ),
    );
  }

  Widget ServiceItem(BuildContext context, UserAccount userAccount, int index) {
    double height = MediaQuery.of(context).size.height;
    return
      InkWell(
        onTap: () {
          Get.toNamed(
              RouteConstant.detailScreen,
              arguments: {
                "UserInfo":
                dataController.foundUsers[index]
              });
        },
        child: Card(
              //color: Colors.green[100],
              //color: index.isEven? Colors.blue[50]:Colors.green[50],
                shape: RoundedRectangleBorder(
                  //side: BorderSide(color: Color(0xFF384A6B), width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                shadowColor: Colors.grey,
                elevation: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 5,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(2, 5, 2, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child:
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(dataController.foundUsers[index].crfafPictureUrl != null ?
                                      Constants.Base_URL + dataController.foundUsers[index].crfafPictureUrl!
                                          : ""),
                                    ),
                                    //ImageIcon(AssetImage("assets/number_plate.png"))
                                    /*Icon(
                                      IconData(int.parse(services.MobileIcon!),
                                          fontFamily: 'LineAwesomeIcons',
                                          fontPackage: 'line_awesome_flutter'),
                                      color: CustomColors.createMaterialColor(
                                          Color(0xFF384A6B)))*/
                                  ))
                            ],
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          userAccount.name.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          userAccount.accountnumber.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(1),
                        child: Text(
                          userAccount.address1Stateorprovince.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,),
                        ),
                      ),
                    ),
                  ],
                ),
          ),
      );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share];

  static const home = MenuItem(text: 'State Code', icon: Icons.home);
  static const share = MenuItem(text: 'StateOrProvince', icon: Icons.share);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
      dataController.FilterStateProvince(1);
        break;
      case MenuItems.share:
        dataController.FilterStateProvince(2);
        break;
    }
  }
}
