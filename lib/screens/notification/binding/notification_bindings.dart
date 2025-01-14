import 'package:get/get.dart';

class NotificationBindings extends Bindings {

  @override
  void dependencies(){
    Get.lazyPut(()=> NotificationBindings());
  }
}