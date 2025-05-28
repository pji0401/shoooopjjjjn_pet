class PlanListResponse {
  final List<Plan> plans;

  PlanListResponse({required this.plans});

  factory PlanListResponse.fromJson(Map<String, dynamic> json) {
    return PlanListResponse(
      plans: (json['plans'] as List<dynamic>?)
          ?.map((item) => Plan.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plans': plans.map((plan) => plan.toJson()).toList(),
    };
  }
}

class Plan {
  final int id;
  final String title;
  final String date;
  final Time time;
  final bool isChecked;

  Plan({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.isChecked,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      time: Time.fromJson(json['time'] ?? {}),
      isChecked: json['isChecked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'time': time.toJson(),
      'isChecked': isChecked,
    };
  }
}

class Time {
  final int hour;
  final int minute;
  final int second;
  final int nano;

  Time({
    required this.hour,
    required this.minute,
    required this.second,
    required this.nano,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      hour: json['hour'] ?? 0,
      minute: json['minute'] ?? 0,
      second: json['second'] ?? 0,
      nano: json['nano'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'minute': minute,
      'second': second,
      'nano': nano,
    };
  }
}