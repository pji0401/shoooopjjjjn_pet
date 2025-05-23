class ApiRequest {
  final String path;
  final Map<String, dynamic>? pathParams;
  final Map<String, dynamic>? queryParams;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? formData;

  const ApiRequest({
    required this.path,
    this.pathParams,
    this.queryParams,
    this.body,
    this.formData,
  });

  String get fullPath {
    if (pathParams == null || pathParams!.isEmpty) return path;
    String result = path;
    pathParams?.forEach((key, value) {
      result = result.replaceAll(':$key', value.toString());
    });
    return result;
  }
}