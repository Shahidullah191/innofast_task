class Images {
  const Images._();

  static String get logo => 'logo'.jpg;
  static String get placeholder => 'placeholder'.jpg;
}

extension on String {
  String get jpg => 'assets/image/$this.jpg';
}