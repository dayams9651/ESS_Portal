

class LeaveOption {
  final int value;
  final String label;

  LeaveOption({required this.value, required this.label});

  factory LeaveOption.fromJson(Map<String, dynamic> json) {
    return LeaveOption(
      value: json['value'],
      label: json['label'],
    );
  }
}

class LeaveBalance {
  final int balance;
  final List<LeaveOption> options;
  final String sessionValue;
  final String approvalLevel;
  final String totalLevel;

  LeaveBalance({
    required this.balance,
    required this.options,
    required this.sessionValue,
    required this.approvalLevel,
    required this.totalLevel,
  });

  factory LeaveBalance.fromJson(Map<String, dynamic> json) {
    var optionsList = (json['leaveOptions']['options'] as List)
        .map((e) => LeaveOption.fromJson(e))
        .toList();
    return LeaveBalance(
      balance: json['leaveBalance']['balance'],
      options: optionsList,
      sessionValue: json['sessionValue'],
      approvalLevel: json['approval_level'] ?? '',
      totalLevel: json['total_level'] ?? '',
    );
  }
}

