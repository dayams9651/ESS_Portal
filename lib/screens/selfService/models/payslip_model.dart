
class Payslip {
  final String name;
  final String code;
  final String designation;
  final String lastSalary;
  final List<Earning> earnings;
  final List<Deduction> deductions;
  final Total total;

  Payslip({
    required this.name,
    required this.code,
    required this.designation,
    required this.lastSalary,
    required this.earnings,
    required this.deductions,
    required this.total,
  });

  factory Payslip.fromJson(Map<String, dynamic> json) {
    return Payslip(
      name: json['basic'][0]['name'],
      code: json['basic'][0]['code'],
      designation: json['basic'][0]['designation'],
      lastSalary: json['basic'][0]['last_salary'],
      earnings: List<Earning>.from(json['earing'].map((x) => Earning.fromJson(x))),
      deductions: List<Deduction>.from(json['deduction'].map((x) => Deduction.fromJson(x))),
      total: Total.fromJson(json['total'][0]),
    );
  }
}

class Earning {
  final String label;
  final String value;

  Earning({required this.label, required this.value});

  factory Earning.fromJson(Map<String, dynamic> json) {
    return Earning(
      label: json['label'],
      value: json['value'],
    );
  }
}

class Deduction {
  final String label;
  final String value;

  Deduction({required this.label, required this.value});

  factory Deduction.fromJson(Map<String, dynamic> json) {
    return Deduction(
      label: json['label'],
      value: json['value'],
    );
  }
}

class Total {
  final int earnings;
  final int deductions;

  Total({required this.earnings, required this.deductions});

  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(
      earnings: json['earnings'],
      deductions: json['deductions'],
    );
  }
}
