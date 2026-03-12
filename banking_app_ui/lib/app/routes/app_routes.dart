part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const TABS = _Paths.TABS;
  static const HOME = _Paths.HOME;
  static const CARD_DETAILS = _Paths.CARD_DETAILS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const TABS = '/tabs';
  static const HOME = '/home';
  static const CARD_DETAILS = '/card-details';
}
