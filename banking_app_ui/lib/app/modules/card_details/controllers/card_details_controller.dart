import 'package:get/get.dart';

class CardDetailsController extends GetxController {
  final isFrozen = false.obs;
  late final String cardType;

  bool get isCredit => cardType == 'credit';

  String get title => isCredit ? 'Credit Card' : 'Debit Card';
  String get balance => isCredit ? '\$ 2,540.05' : '\$ 0.00';
  String get paymentTitle =>
      isCredit ? 'Credit Card Payments' : 'Debit Card Overview';
  String get paymentBanner =>
      isCredit ? 'No interest in next 7 days!' : 'No card fees this month!';
  String get paymentAmount => isCredit ? '\$ 459.95' : '\$ 0.00';
  String get paymentText => isCredit
      ? 'This payment must be covered by May 17\nto meet the interest-free period'
      : 'Your debit card is active and ready for\ndaily purchases and transfers';

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    cardType = args?['type'] == 'debit' ? 'debit' : 'credit';
  }

  void toggleFreeze(bool value) {
    isFrozen.value = value;
  }
}
