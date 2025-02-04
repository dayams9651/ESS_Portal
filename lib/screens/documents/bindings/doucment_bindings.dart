import 'package:get/get.dart';

import '../controller/documents_controller.dart';

class DocumentsBindings extends Bindings {

  @override
  void dependencies(){
    Get.lazyPut(()=> SOPController());
  }
}