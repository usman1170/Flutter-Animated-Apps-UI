import 'package:get/get.dart';

class CardDetailsController extends GetxController {
  final isFrozen = false.obs;
  late final String cardType;

  bool get isCredit => cardType == 'credit';
  String get heroTag => isCredit ? 'card-credit' : 'card-debit';

  String get title => isCredit ? 'Credit Card' : 'Debit Card';
  String get holderName => 'Usman Ghani';
  String get balance => isCredit ? '\$ 2,540.05' : '\$ 0.00';
  String get paymentTitle =>
      isCredit ? 'Credit Card Payments' : 'Debit Card Overview';
  String get paymentBanner =>
      isCredit ? 'No interest in next 7 days!' : 'No card fees this month!';
  String get paymentAmount => isCredit ? '\$ 459.95' : '\$ 0.00';
  String get paymentText => isCredit
      ? 'This payment must be covered by May 17\nto meet the interest-free period'
      : 'Your debit card is active and ready for\ndaily purchases and transfers';
  String get primaryButtonLabel => isCredit ? 'Pay Now' : 'View Card';
  String get autopayTitle => isCredit ? 'Autopay' : 'Smart Controls';
  String get autopayText => isCredit
      ? 'Set up autopay to automatically cover card payments and pay fines'
      : 'Manage online usage, ATM access and card settings in one place';
  String get limitLabel => isCredit ? 'Credit Limit' : 'Daily Limit';
  String get limitValue => isCredit ? '\$ 3,000' : '\$ 5,000';
  String get debtLabel => isCredit ? 'Debt' : 'Pending Holds';
  String get debtValue => isCredit ? '\$ 459.95' : '\$ 0.00';
  String get freezeLabel => isCredit ? 'Freeze Account' : 'Freeze Card';
  String get detailsShareText => isCredit
      ? 'Share a PDF-file with bank details'
      : 'Share a PDF-file with card and account details';

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
