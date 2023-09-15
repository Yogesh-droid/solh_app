class RequestParams {
  final String url;
  final ApiMethods? apiMethods;
  final Map<String, dynamic>? body;

  const RequestParams({required this.url, this.apiMethods, this.body});
}

enum ApiMethods { get, post, delete, put, patch, multipart, download }
