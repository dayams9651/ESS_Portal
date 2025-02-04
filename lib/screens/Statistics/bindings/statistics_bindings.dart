
import 'package:get/get.dart';

import '../controller/statistics_controller.dart';

class StatisticsBindings extends Bindings {

  @override
  void dependencies(){
    Get.lazyPut(()=> StatisticsController());
  }
}