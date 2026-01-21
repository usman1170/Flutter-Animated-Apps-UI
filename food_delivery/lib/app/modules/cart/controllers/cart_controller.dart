import 'package:get/get.dart';

import '../../restaurant_list/data/restaurant_data.dart';

class CartController extends GetxController {
  final items = <Product>[].obs;

  int get count => items.length;

  double get subtotal =>
      items.fold(0, (total, item) => total + item.price);

  void add(Product product) {
    items.add(product);
  }

  void remove(Product product) {
    items.remove(product);
  }

  void clear() {
    items.clear();
  }
}
