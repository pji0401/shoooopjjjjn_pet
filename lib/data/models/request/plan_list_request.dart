class PlanListRequest {
  final int memberId;
  final String date;

  PlanListRequest({
    required this.memberId,
    required this.date,
  });

  factory PlanListRequest.fromJson(Map<String, dynamic> json) {
    return PlanListRequest(
      memberId: json['memberId'] ?? 0,
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'date': date,
    };
  }
}