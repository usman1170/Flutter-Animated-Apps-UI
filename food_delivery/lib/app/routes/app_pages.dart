import 'package:get/get.dart';

import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/product_detail/bindings/product_detail_binding.dart';
import '../modules/product_detail/views/product_detail_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/restaurant_detail/bindings/restaurant_detail_binding.dart';
import '../modules/restaurant_detail/views/restaurant_detail_view.dart';
import '../modules/restaurant_list/bindings/restaurant_list_binding.dart';
import '../modules/restaurant_list/views/restaurant_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.RESTAURANT_LIST,
      page: () => const RestaurantListView(),
      binding: RestaurantListBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.RESTAURANT_DETAIL,
      page: () => const RestaurantDetailView(),
      binding: RestaurantDetailBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
  ];
}
