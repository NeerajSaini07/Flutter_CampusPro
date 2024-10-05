import 'package:campuspro/Modal/student_module/transport_detail_model.dart';

import 'package:campuspro/Repository/StudentRepositories/transport_detail_repo.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';

class TransportdetailController extends GetxController {
  var isLoading = true.obs;
  var info = <Studentinfo>[].obs;
  var pickinfo = <Pickupinfo>[].obs;
  var dropinfoo = <Dropinfo>[].obs;

  Future<void> fetchtransportData() async {
    isLoading(true);
    try {
      var response = await TransportDetailRepo.gettransportdetail();
      if (response != null) {
        List<dynamic> infoData = response['Data1'] ?? [];
        List<dynamic> pickinfoData = response['Data2'] ?? [];
        List<dynamic> dropinfoData = response['Data3'] ?? [];
        // TransportDetailModel data = TransportDetailModel.fromJson(response['Data']);
        TransportDetailModel.infoDataList =
            infoData.map((json) => Studentinfo.fromJson(json)).toList();
        TransportDetailModel.pickinfoDataList =
            pickinfoData.map((json) => Pickupinfo.fromJson(json)).toList();
        TransportDetailModel.dropinfooDataList =
            dropinfoData.map((json) => Dropinfo.fromJson(json)).toList();

        info.assignAll(TransportDetailModel.infoDataList);
        pickinfo.assignAll(TransportDetailModel.pickinfoDataList);
        dropinfoo.assignAll(TransportDetailModel.dropinfooDataList);
      } else if (response['Status'] == 'Cam-003') {
        Get.toNamed(Routes.userType);
      }
    } catch (e) {
      print("Error fetching detail: $e");
    } finally {
      isLoading(false);
    }
  }
}
