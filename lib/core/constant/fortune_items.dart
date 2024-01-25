import 'dart:ui';

class Items {
  late String image;
  late Color color;
  late String number;

  Items(this.image, this.color, this.number);

  @override
  String toString() {
    return 'Items{image: $image, color: $color, number: $number}';
  }

  static List<Items> getItems() {
    return [
      Items('assets/heart.png', const Color.fromARGB(255, 40, 224, 3), '5'),
      Items('assets/diamond.png', const Color.fromARGB(255, 34, 185, 4), '1'),
      Items('assets/heart.png', const Color.fromARGB(255, 25, 136, 3), '10'),
      Items('assets/diamond.png', const Color.fromARGB(255, 2, 83, 33), '50'),
      Items('assets/heart.png', const Color.fromARGB(255, 7, 240, 131), '2'),
      Items('assets/diamond.png', const Color.fromARGB(255, 7, 240, 209), '8'),
      Items('assets/heart.png', const Color.fromARGB(255, 3, 83, 97), '6'),
      Items('assets/diamond.png', const Color.fromARGB(253, 7, 127, 240), '15'),
    ];
  }
}
