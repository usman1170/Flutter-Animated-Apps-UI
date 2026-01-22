import 'package:get/get.dart';

import '../modules/forecast_detail/bindings/forecast_detail_binding.dart';
import '../modules/forecast_detail/views/forecast_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/location/bindings/location_binding.dart';
import '../modules/location/views/location_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import 'app_transitions.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION,
      page: () => const LocationView(),
      binding: LocationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FORECAST_DETAIL,
      page: () => const ForecastDetailView(),
      binding: ForecastDetailBinding(),
      customTransition: FadeScaleTransition(),
    ),
  ];
}
