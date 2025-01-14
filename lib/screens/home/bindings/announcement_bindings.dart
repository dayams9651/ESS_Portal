import 'package:get/get.dart';

import '../controller/announcement_controller.dart';

class AnnouncementBindings extends Bindings {

  @override
  void dependencies(){
    Get.lazyPut(()=> AnnouncementController());
  }
}