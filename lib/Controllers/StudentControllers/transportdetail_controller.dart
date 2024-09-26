import 'package:campuspro/Modal/student_module/transport_detail_model.dart';

import 'package:campuspro/Repository/StudentRepositories/transport_detail_repo.dart';
import 'package:get/get.dart';

class TransportdetailController extends GetxController {
  var isLoading = true.obs;
  var info = <Studentinfo>[].obs;
  var pickinfo = <Pickupinfo>[].obs;
  var dropinfoo = <Dropinfo>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchtransportData();
  }

  Future<void> fetchtransportData() async {
    isLoading(true); // Set loading to true while data is being fetched
    try {
      var response = await TransportDetailRepo.gettransportdetail();
      if (response != null) {
        // Assuming you have a fromJson method to parse response into models
        TransportDetailModel data =
            TransportDetailModel.fromJson(response['Data']);

        // Update the observable lists with fetched data
        info.assignAll(data.info);
        pickinfo.assignAll(data.pickinfo);
        dropinfoo.assignAll(data.dropinfoo);
      }
    } catch (e) {
      print("Error fetching detail: $e");
    } finally {
      isLoading(false);
    }
  }
}
