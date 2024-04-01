class FunctionGol {
  static String getDomainFromUrl(String url) {
    Uri uri = Uri.parse(url);
    return uri.host;
  }
}
