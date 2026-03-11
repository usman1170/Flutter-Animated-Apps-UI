part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const TABS = _Paths.TABS;
  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  _Paths._();
  static const TABS = '/tabs';
  static const HOME = '/home';
}
