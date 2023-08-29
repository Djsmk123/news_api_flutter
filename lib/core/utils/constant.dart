class APIInfo {
  String getBaseUrl() => "https://newsapi.org";

  String subBaseUrl() => "/";

  String apiVersion() => "/v2";

  Map<String, String> defaultHeader = {
    'Content-Type': 'application/json',
  };

  String apiKey = const String.fromEnvironment('api-key',
      defaultValue: "5733eb82f6304e8f8dce26f6fd0ea8fd");
}
