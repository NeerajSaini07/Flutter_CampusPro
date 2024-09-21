// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:campuspro/Modal/dashboard_menu.dart';
import 'package:campuspro/Modal/drawer_model.dart';
import 'package:campuspro/Modal/login_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Repository/checkmenu_chnages_repository.dart';
import 'package:campuspro/Repository/usertype_repo.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:campuspro/localdatabase/db_helper.dart';
import 'package:campuspro/localdatabase/menu_model.dart';
import 'package:get/get.dart';
import '../localdatabase/dashboard_menu_model.dart';

class UserMenuController extends GetxController {
  var NewRefreshDateTime = '';
  var updatedmenudate = '';
  final db_helper = DatabaseManager();
  getmenuFromServer(index) async {
    await checkmenuchanges();
    await lastupdatemenu();
    var usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

//  ************************** checking the  new menu update  ******************

    if (NewRefreshDateTime == updatedmenudate) {
      // ************************* if no new menu added for this user  then get the data from local database ************
      await db_helper
          .getmenudata(UserTypeslist.userTypesDetails[usertypeIndex].ouserType)
          .then((value) {
        String drawerDataJson = value![0]['drawerData'];
        List<dynamic> drawerDataList = jsonDecode(drawerDataJson);
        MenuItemList.menuItemDetails =
            drawerDataList.map((json) => DrawerMenu.fromJson(json)).toList();
      });

      // *******************************  for dashboard Menu ***************************
      await db_helper
          .getDashboardMenu(
              UserTypeslist.userTypesDetails[usertypeIndex].ouserType)
          .then((value) {
        String dashboardmenu = value![0]['dashboardmenu'];

        List<dynamic> dashbaordMenuList = jsonDecode(dashboardmenu);
        DashboardMenulist.dashboardMenulistdetails = dashbaordMenuList
            .map((json) => Dashboardmenumodel.fromJson(json))
            .toList();
      });
    } else {
//  **********************  take the data ffrom api call the api for finding the menu list ****************

      await UserTypeRepository.getDrawerData(index).then((value) async {
        List<dynamic> data = value['Data'];
        List<dynamic> dashboardmenudata = value['DashboardData'];

        MenuItemList.menuItemDetails =
            data.map((json) => DrawerMenu.fromJson(json)).toList();

        DashboardMenulist.dashboardMenulistdetails = dashboardmenudata
            .map((json) => Dashboardmenumodel.fromJson(json))
            .toList();

        // ********************************** uploading user menu in local database **************************
        final usermobile =
            await Sharedprefdata.getStrigData(Sharedprefdata.mobile);

        //  **************************  for lest side drawer menu *************

        final userData = UserData(
          mobileNo: usermobile.toString(),
          userId: UserLogin.loginDetails.last.oUserid.toString(),
          updatedDate: NewRefreshDateTime,
          orgId:
              UserTypeslist.userTypesDetails[index].organizationId.toString(),
          schoolId: UserTypeslist.userTypesDetails[index].schoolId.toString(),
          userType: UserTypeslist.userTypesDetails[index].ouserType.toString(),
          drawerData: data.map((json) => DrawerMenu.fromJson(json)).toList(),
        );

        db_helper.insertOrUpdateUserData(userData,
            UserTypeslist.userTypesDetails[index].ouserType.toString());

        //  ******************  for dashboard menu ******************************

        final userdashboardMenudata = DashboardMenuModelLocalDb(
          mobileNo: usermobile.toString(),
          userId: UserLogin.loginDetails.last.oUserid.toString(),
          updatedDate: NewRefreshDateTime,
          orgId:
              UserTypeslist.userTypesDetails[index].organizationId.toString(),
          schoolId: UserTypeslist.userTypesDetails[index].schoolId.toString(),
          userType: UserTypeslist.userTypesDetails[index].ouserType.toString(),
          dashboardMenu: dashboardmenudata
              .map((json) => Dashboardmenumodel.fromJson(json))
              .toList(),
        );

        db_helper.insertOrUpdateUserDataforDashboardMenu(userdashboardMenudata,
            UserTypeslist.userTypesDetails[index].ouserType.toString());
      });
    }
  }

  //  ******************  chech the update time in server *****************************

  checkmenuchanges() async {
    await CheckmenuchangesRepo.getApiCallStatusRepo().then((value) {
      if (value['Status'] == 'Cam-001') {
        print(value);
        NewRefreshDateTime = value['Data'][0]['NewRefreshDateTime'];
      }
    });
  }

//  ****************  check in the last update time in local db **************

  lastupdatemenu() async {
    var usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
    await db_helper
        .getUpdatedDateByUserType(
            UserTypeslist.userTypesDetails[usertypeIndex].ouserType.toString())
        .then((value) {
      if (value == null) {
        updatedmenudate = '0';
      } else {
        updatedmenudate = value.toString();
      }
    });
  }

  //  *********************************************************
}
