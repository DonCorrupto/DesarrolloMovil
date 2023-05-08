class listImagenes {
  String url;

  listImagenes({
    required this.url,
  });

  @override
  String toString() {
    return url.toLowerCase();
  }
}
