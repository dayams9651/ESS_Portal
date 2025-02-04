import 'package:get/get.dart';
import '../controller/leaveWFH_controller.dart';

class LeaveWFHBindings extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut(()=> LeaveWFHController());
  }
}