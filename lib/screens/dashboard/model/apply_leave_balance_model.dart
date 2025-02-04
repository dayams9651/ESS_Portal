class LeaveResponseModel {
  bool? success;
  String? status;
  Data? data;

  LeaveResponseModel({this.success, this.status, this.data});

  LeaveResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  LeaveBalance? leaveBalance;
  LeaveOptions? leaveOptions;
  String? sessionValue;
  String? approvalLevel;
  String? totalLevel;

  Data(
      {this.leaveBalance,
        this.leaveOptions,
        this.sessionValue,
        this.approvalLevel,
        this.totalLevel});

  Data.fromJson(Map<String, dynamic> json) {
    leaveBalance = json['leaveBalance'] != null
        ? new LeaveBalance.fromJson(json['leaveBalance'])
        : null;
    leaveOptions = json['leaveOptions'] != null
        ? new LeaveOptions.fromJson(json['leaveOptions'])
        : null;
    sessionValue = json['sessionValue'];
    approvalLevel = json['approval_level'];
    totalLevel = json['total_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveBalance != null) {
      data['leaveBalance'] = this.leaveBalance!.toJson();
    }
    if (this.leaveOptions != null) {
      data['leaveOptions'] = this.leaveOptions!.toJson();
    }
    data['sessionValue'] = this.sessionValue;
    data['approval_level'] = this.approvalLevel;
    data['total_level'] = this.totalLevel;
    return data;
  }
}

class LeaveBalance {
  dynamic balance;

  LeaveBalance({this.balance});

  LeaveBalance.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    return data;
  }
}

class LeaveOptions {
  List<Options>? options;

  LeaveOptions({this.options});

  LeaveOptions.fromJson(Map<String, dynamic> json) {
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? value;
  String? label;

  Options({this.value, this.label});

  Options.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}
