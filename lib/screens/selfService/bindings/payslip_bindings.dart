import 'package:get/get.dart';
import '../controller/paylip_controller.dart';

class PayslipBindings extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut(()=> PayslipController());
  }
}