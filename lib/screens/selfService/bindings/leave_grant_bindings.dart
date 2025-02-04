import 'package:get/get.dart';
import 'package:ms_ess_portal/screens/selfService/controller/leaveStatus_controller.dart';

class LeaveGrantBindings extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(()=> LeaveStatusController());
  }
}