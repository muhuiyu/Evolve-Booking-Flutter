enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete;

  @override
  String toString() {
    return name.toUpperCase();
  }

  bool get canHaveBody {
    return this == HttpMethod.post ||
        this == HttpMethod.put ||
        this == HttpMethod.patch;
  }
}
