class Images {
  const Images._();

  static String get logo => 'logo'.png;
  static String get placeholder => 'placeholder'.jpg;
  static String get english => 'english'.jpg;
  static String get bengali => 'bengali'.jpg;
}


extension on String {
  //String get svg => 'assets/image/$this.svg';
  String get png => 'assets/image/$this.png';
  String get jpg => 'assets/image/$this.jpg';
}