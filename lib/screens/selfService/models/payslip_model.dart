class Payslip {
  final bool success;
  final String status;
  final PayslipData data;

  Payslip({required this.success, required this.status, required this.data});

  factory Payslip.fromJson(Map<String, dynamic> json) {
    return Payslip(
      success: json['success'],
      status: json['status'],
      data: PayslipData.fromJson(json['data']),
    );
  }
}

class PayslipData {
  final List<BasicInfo> basic;
  final List<Earning> earing;
  final List<Deduction> deduction;
  final List<Total> total;

  PayslipData({required this.basic, required this.earing, required this.deduction, required this.total});

  factory PayslipData.fromJson(Map<String, dynamic> json) {
    return PayslipData(
      basic: List<BasicInfo>.from(json['basic'].map((x) => BasicInfo.fromJson(x))),
      earing: List<Earning>.from(json['earing'].map((x) => Earning.fromJson(x))),
      deduction: List<Deduction>.from(json['deduction'].map((x) => Deduction.fromJson(x))),
      total: List<Total>.from(json['total'].map((x) => Total.fromJson(x))),
    );
  }
}

class BasicInfo {
  final String name;
  final String code;
  final String designation;
  final String lastSalary;

  BasicInfo({required this.name, required this.code, required this.designation, required this.lastSalary});

  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(
      name: json['name'],
      code: json['code'],
      designation: json['designation'],
      lastSalary: json['last_salary'],
    );
  }
}

class Earning {
  final String label;
  final String? value;

  Earning({required this.label, this.value});

  factory Earning.fromJson(Map<String, dynamic> json) {
    return Earning(
      label: json['label'],
      value: json['value'],
    );
  }
}

class Deduction {
  final String label;
  final String? value;

  Deduction({required this.label, this.value});

  factory Deduction.fromJson(Map<String, dynamic> json) {
    return Deduction(
      label: json['label'],
      value: json['value'],
    );
  }
}

class Total {
  final String? earnings;
  final int deductions;

  Total({this.earnings, required this.deductions});

  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(
      earnings: json['earnings'],
      deductions: json['deductions'],
    );
  }
}
