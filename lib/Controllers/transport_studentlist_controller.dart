import 'dart:developer';

import 'package:campuspro/Modal/student_list_area_dropdown_model.dart';
import 'package:campuspro/Modal/student_list_detail_model.dart';
import 'package:campuspro/Modal/student_list_route_dropdown_model.dart';
import 'package:campuspro/Repository/transport_module_repository.dart';
import 'package:campuspro/Screens/TransportModule/studentList/student_list_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransportStudentListController extends GetxController {
  final ScrollController scrollController = ScrollController();
  //Route DropDown
  RxList<StudentTable> routeList = <StudentTable>[].obs;
  RxInt selectedRouteId = 0.obs;
  //Area DropDown
  RxList<StudentAreaTable> areaList = <StudentAreaTable>[].obs;
  RxInt selectedAreaId = 0.obs;
  //Student List Details
  RxList<StudentDetailsTable> studentListDetail = <StudentDetailsTable>[].obs;
  RxInt sNo = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedAreaId.value = 0;
    selectedRouteId.value = 0;
    getTransportRouteDropDown();
  }

  @override
  void onClose() {
    scrollController.dispose();
    selectedAreaId.value = 0;
    selectedRouteId.value = 0;
    super.onClose();
  }

  void setSelectedRoute(int routeId) {
    selectedRouteId.value = routeId;
  }

  void setSelectedArea(int areaId) {
    selectedAreaId.value = areaId;
  }

  void scrollToTop(double scrollingValue) {
    scrollController.animateTo(
      scrollingValue,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  getTransportRouteDropDown() async {
    try {
      await TransportModuleRepository.getStudentListRouteDropDown()
          .then((response) async {
        log(response.toString());
        var routeDropDown = StudentListRouteDropDown.fromJson(response);
        if (routeDropDown.status == "Cam-001") {
          routeList.value = routeDropDown.data.table;
        } else {
          routeList.value = [];
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  getTransportAreaDropDown(int routeId) async {
    try {
      areaList.value = [];
      selectedAreaId.value = 0;
      await TransportModuleRepository.getStudentListAreaDropDown(
              routeId.toString())
          .then((response) async {
        log(response.toString());
        var areaDropDown = StudentListAreaDropDown.fromJson(response);
        if (areaDropDown.status == "Cam-001") {
          areaList.value = areaDropDown.data.table;
        } else {
          areaList.value = [];
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  getTransportStudentListDetail() async {
    try {
      await TransportModuleRepository.getStudentListDetails(
              selectedRouteId.value.toString(), selectedAreaId.value.toString())
          .then((response) async {
        log(response.toString());
        if (response != null) {
          var studentListData = StudentListDetailModel.fromJson(response);
          if (studentListData.status == "Cam-001") {
            studentListDetail.value = studentListData.data.table;
          } else {
            studentListDetail.value = [];
          }
          Get.to(const StudentListDetail());
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
