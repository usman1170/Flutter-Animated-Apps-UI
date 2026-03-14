import 'package:get/get.dart';

import '../modules/card_details/bindings/card_details_binding.dart';
import '../modules/card_details/views/card_details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/housing_utilities/bindings/housing_utilities_binding.dart';
import '../modules/housing_utilities/views/housing_utilities_view.dart';
import '../modules/internet_tv/bindings/internet_tv_binding.dart';
import '../modules/internet_tv/views/internet_tv_view.dart';
import '../modules/payments/views/transfer_flow_view.dart';
import '../modules/payments/views/widgets/transfer_flow_models.dart';
import '../modules/phone_bills/bindings/phone_bills_binding.dart';
import '../modules/phone_bills/views/phone_bills_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tabs/bindings/tabs_binding.dart';
import '../modules/tabs/views/tabs_view.dart';

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
      name: _Paths.TABS,
      page: () => const TabsView(),
      binding: TabsBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CARD_DETAILS,
      page: () => const CardDetailsView(),
      binding: CardDetailsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSFER_FLOW,
      page: () => TransferFlowView(
        type:
            Get.arguments as TransferFlowType? ??
            TransferFlowType.byAccountDetails,
      ),
    ),
    GetPage(
      name: _Paths.PHONE_BILLS,
      page: () => const PhoneBillsView(),
      binding: PhoneBillsBinding(),
    ),
    GetPage(
      name: _Paths.INTERNET_TV,
      page: () => const InternetTvView(),
      binding: InternetTvBinding(),
    ),
    GetPage(
      name: _Paths.HOUSING_UTILITIES,
      page: () => const HousingUtilitiesView(),
      binding: HousingUtilitiesBinding(),
    ),
  ];
}
