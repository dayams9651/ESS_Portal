import 'package:get/get.dart';
import 'package:ms_ess_potal/screens/selfService/controller/leave_grant_controller.dart';

class LeaveGrantBindings extends Bindings {

  @override
  void dependencies(){
    Get.lazyPut(()=> LeaveGrantController());
  }
}