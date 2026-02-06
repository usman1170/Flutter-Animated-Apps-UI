import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/my_cameras/bindings/my_cameras_binding.dart';
import '../modules/my_cameras/views/my_cameras_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MY_CAMERAS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MY_CAMERAS,
      page: () => const MyCamerasView(),
      binding: MyCamerasBinding(),
    ),
  ];
}
