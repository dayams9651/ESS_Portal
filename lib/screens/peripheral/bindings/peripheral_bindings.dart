
import 'package:get/get.dart';

import '../controller/peripheral_controller.dart';

class PeripheralBindings extends Bindings {

  @override
  void dependencies(){
    Get.lazyPut(()=> AssetController());
  }
}