import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedCardIndex = 0.obs;
  final isBalanceVisible = false.obs;

  void toggleBalance() {
    isBalanceVisible.toggle();
  }
}
