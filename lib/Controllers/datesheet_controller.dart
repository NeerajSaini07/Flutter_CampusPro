import 'dart:developer';
import 'package:campuspro/Modal/student_module/student_datesheet_model.dart';
import 'package:campuspro/Repository/StudentRepositories/datesheet_repo.dart';
import 'package:get/get.dart';

class StudentDatesheetController extends GetxController {



  datesheetsData() async {
   
      await StudentdatesheetRepo.getdatesheet().then((value) {
         try{
            if (value != null) {
              // if (value['Status'] == "Cam-001") {
                List<dynamic> listdata = value['Data'];
           
                Datesheetl.datesheetlist = listdata
                    .map((json) => Datesheetmodel.fromJson(json))
                    .toList();
              // }
            }
             }catch(e){
      log(e.toString());
    }
          });
   
    
  }
  }

  