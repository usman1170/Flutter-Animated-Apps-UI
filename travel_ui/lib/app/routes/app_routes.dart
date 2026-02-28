part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const tabs = _Paths.tabs;
  static const home = _Paths.home;
}

abstract class _Paths {
  _Paths._();
  static const tabs = '/tabs';
  static const home = '/home';
}
