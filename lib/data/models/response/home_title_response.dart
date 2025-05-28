class HomeTitleResponse {
  final String name;
  final int memoryCount;
  final String pname;

  HomeTitleResponse({
    required this.name,
    required this.memoryCount,
    required this.pname,
  });

  factory HomeTitleResponse.fromJson(Map<String, dynamic> json) {
    return HomeTitleResponse(
      name: json['name'] ?? '',
      memoryCount: json['memoryCount'] ?? 0,
      pname: json['pname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'memoryCount': memoryCount,
      'pname': pname,
    };
  }
}