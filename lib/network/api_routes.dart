class ApiRoutes {
  static String baseUrl =
      "https://api-sandbox.renmoney.com/deposit-transfer/api/"
      "v3/investment/3580016662/transactions";

  static Uri create(String endpoint, {bool ignoreBaseUrl = false}) {
    if (ignoreBaseUrl) return Uri.parse(endpoint);
    return Uri.parse(baseUrl + endpoint);
  }
}
