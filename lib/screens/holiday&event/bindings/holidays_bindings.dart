import 'package:get/get.dart';

import '../controller/holiday_controller.dart';

class HolidaysBindings extends Bindings {

  @override
  void dependencies(){
    Get.lazyPut(()=> HolidayController());
  }
}