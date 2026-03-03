part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const TABS = _Paths.TABS;
  static const HOME = _Paths.HOME;
  static const SEARCH = _Paths.SEARCH;
  static const BOOKINGS = _Paths.BOOKINGS;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const TABS = '/tabs';
  static const HOME = '/home';
  static const SEARCH = '/search';
  static const BOOKINGS = '/bookings';
  static const PROFILE = '/profile';
}
