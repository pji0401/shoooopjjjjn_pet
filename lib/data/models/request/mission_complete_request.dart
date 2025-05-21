class MissionCompleteRequest {
  final int missionId;
  final int memberId;
  final String body;
  final String date;

  MissionCompleteRequest({
    required this.missionId,
    required this.memberId,
    required this.body,
    required this.date,
  });

  factory MissionCompleteRequest.fromJson(Map<String, dynamic> json) {
    return MissionCompleteRequest(
      missionId: json['missionId'] as int,
      memberId: json['memberId'] as int,
      body: json['body'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'missionId': missionId,
    'memberId': memberId,
    'body': body,
    'date': date,
  };
}