import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_ess_portal/common/widget/const_shimmer_effects.dart';
import 'package:ms_ess_portal/screens/home/controller/hierarchy_controller.dart';
import 'package:ms_ess_portal/style/color.dart';
import 'package:shimmer/shimmer.dart';

import '../../../style/text_style.dart';
import '../model/hierarchy_model.dart';

class EmployeeView extends StatelessWidget {
  final EmployeeController _employeeController = Get.put(EmployeeController());
   EmployeeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Center(child: Text("Hierarchy Chart", style: AppTextStyles.kPrimaryTextStyle)),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 24),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (_employeeController.isLoading.value) {
          return Shimmer.fromColors(baseColor: baseColor, highlightColor: highLightColor, child: loadSke());
        } else {
          return ListView.builder(
            itemCount: _employeeController.employeeList.length,
            itemBuilder: (context, index) {
              var employee = _employeeController.employeeList[index];
              return EmployeeTile(employee: employee);
            },
          );
        }
      }),
    );
  }
}

class EmployeeTile extends StatelessWidget {
  final Employee employee;
  const EmployeeTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    // Use ValueNotifier to manage expansion state
    ValueNotifier<bool> _isExpanded = ValueNotifier(false);

    return Card(
      color: AppColors.white,
      elevation: 15,
      child: ExpansionTile(
        onExpansionChanged: (bool expanded) {
          // Update the expansion state
          _isExpanded.value = expanded;
        },
        title: Text(
          employee.name,
          style: AppTextStyles.kSmall12SemiBoldTextStyle,
        ),
        subtitle: Text(
          employee.title,
          style: AppTextStyles.kSmall10RegularTextStyle,
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(employee.imageUrl.isNotEmpty ? employee.imageUrl : "empty"),
        ),
        trailing: ValueListenableBuilder<bool>(
          valueListenable: _isExpanded,
          builder: (context, isExpanded, child) {
            return CircleAvatar(
              backgroundColor: AppColors.success40,
              child: Icon(
                isExpanded ? Icons.remove : Icons.add,
                size: 24,
              ),
            );
          },
        ),
        children: employee.children.map((child) {
          return EmployeeTile(employee: child);
        }).toList(),
      ),
    );
  }
}

