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
  final String time;
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
      time: json['time'] ?? '',
      isChecked: json['isChecked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'time': time,
      'isChecked': isChecked,
    };
  }
}