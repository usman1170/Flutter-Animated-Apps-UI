import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../tabs/controllers/tabs_controller.dart';
import 'widgets/transfer_flow_chrome.dart';
import 'widgets/transfer_flow_forms.dart';
import 'widgets/transfer_flow_models.dart';
import 'widgets/transfer_flow_receipt.dart';
import 'widgets/transfer_flow_surface.dart';

class TransferFlowView extends StatefulWidget {
  final TransferFlowType type;

  const TransferFlowView({super.key, required this.type});

  @override
  State<TransferFlowView> createState() => _TransferFlowViewState();
}

class _TransferFlowViewState extends State<TransferFlowView>
    with TickerProviderStateMixin {
  final amountController = TextEditingController(text: '2450');
  final otpController = TextEditingController(text: '4582');
  final cardNumberController = TextEditingController(
    text: '5214 8712 0923 4012',
  );
  final cardHolderController = TextEditingController(text: 'Mikael Khan');
  final bankAccountController = TextEditingController(
    text: 'PK36 HABB 0001 2398 7712 45',
  );
  final accountTitleController = TextEditingController(
    text: 'Studio Vertex LLC',
  );
  final purposeController = TextEditingController(
    text: 'Design retainer for March',
  );

  int currentStep = 0;
  String selectedBank = 'Habib Bank';
  String fromAccount = 'Daily Spending • 1834';
  String toAccount = 'Savings Vault • 9921';

  List<String> get steps => widget.type.steps;
  bool get isReceiptStep => currentStep == steps.length - 1;

  @override
  void dispose() {
    amountController.dispose();
    otpController.dispose();
    cardNumberController.dispose();
    cardHolderController.dispose();
    bankAccountController.dispose();
    accountTitleController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.screenBackground(context),
      body: Stack(
        children: [
          Positioned.fill(
            child: TransferFlowBackdrop(accent: widget.type.accent),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Row(
                    children: [
                      TransferRoundButton(
                        icon: LucideIcons.chevronLeft,
                        onTap: currentStep == 0 ? Get.back<void> : _back,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: TransferHeader(
                          title: widget.type.title,
                          subtitle: widget.type.subtitle,
                        ),
                      ),
                      const SizedBox(width: 14),
                      TransferRoundButton(
                        icon: LucideIcons.home,
                        onTap: _goHome,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: TransferStepProgress(
                    labels: steps,
                    currentIndex: currentStep,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    child: Column(
                      children: [
                        TransferHeroCard(
                          icon: widget.type.icon,
                          amountText: amountController.text,
                          badgeText: steps[currentStep],
                          accent: widget.type.accent,
                        ),
                        const SizedBox(height: 18),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 360),
                          curve: Curves.easeOutCubic,
                          alignment: Alignment.topCenter,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 320),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeOutCubic,
                            layoutBuilder: (currentChild, previousChildren) {
                              return Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  ...previousChildren,
                                  ...?(currentChild != null
                                      ? [currentChild]
                                      : null),
                                ],
                              );
                            },
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutCubic,
                                ),
                                child: SlideTransition(
                                  position:
                                      Tween<Offset>(
                                        begin: const Offset(0.02, 0.02),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeOutCubic,
                                        ),
                                      ),
                                  child: child,
                                ),
                              );
                            },
                            child: isReceiptStep
                                ? TransferReceiptCard(
                                    key: const ValueKey('receipt'),
                                    type: widget.type,
                                    amount: amountController.text,
                                    fromLabel: _fromLabel,
                                    toLabel: _toLabel,
                                    reference: purposeController.text,
                                    bank: selectedBank,
                                  )
                                : TransferFlowForms(
                                    key: ValueKey(
                                      '${widget.type.name}-$currentStep',
                                    ),
                                    type: widget.type,
                                    currentStep: currentStep,
                                    selectedBank: selectedBank,
                                    fromAccount: fromAccount,
                                    toAccount: toAccount,
                                    amountController: amountController,
                                    otpController: otpController,
                                    cardNumberController: cardNumberController,
                                    cardHolderController: cardHolderController,
                                    bankAccountController:
                                        bankAccountController,
                                    accountTitleController:
                                        accountTitleController,
                                    purposeController: purposeController,
                                    onBankChanged: (value) =>
                                        setState(() => selectedBank = value),
                                    onFromChanged: (value) =>
                                        setState(() => fromAccount = value),
                                    onToChanged: (value) =>
                                        setState(() => toAccount = value),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: TransferFooter(
                    accent: widget.type.accent,
                    isReceiptStep: isReceiptStep,
                    isFirstStep: currentStep == 0,
                    onBack: currentStep == 0 ? Get.back<void> : _back,
                    onNext: isReceiptStep ? Get.back<void> : _next,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _back() => setState(() => currentStep -= 1);

  void _next() {
    if (!_isCurrentStepValid()) return;
    setState(() => currentStep += 1);
  }

  void _goHome() {
    if (Get.isRegistered<TabsController>()) {
      Get.find<TabsController>().changeTab(0);
    }

    var foundTabs = false;
    Get.until((route) {
      final isTabs = route.settings.name == Routes.TABS;
      if (isTabs) foundTabs = true;
      return isTabs || route.isFirst;
    });

    if (!foundTabs) {
      Get.offAllNamed(Routes.TABS);
    }
  }

  bool _isCurrentStepValid() {
    if (widget.type == TransferFlowType.betweenAccounts &&
        currentStep == 0 &&
        fromAccount == toAccount) {
      return _showError('Choose different source and destination accounts.');
    }
    if (widget.type == TransferFlowType.byCardNumber && currentStep == 0) {
      if (cardHolderController.text.trim().isEmpty ||
          cardNumberController.text.replaceAll(' ', '').length < 16) {
        return _showError('Enter a valid card number and recipient name.');
      }
    }
    if (widget.type == TransferFlowType.byAccountDetails && currentStep == 1) {
      if (bankAccountController.text.trim().length < 12 ||
          accountTitleController.text.trim().isEmpty) {
        return _showError(
          'Complete the beneficiary details before continuing.',
        );
      }
    }
    if (currentStep == steps.length - 3) {
      final amount = double.tryParse(amountController.text.trim());
      if (amount == null || amount <= 0) {
        return _showError('Enter a valid transfer amount.');
      }
    }
    if (currentStep == steps.length - 2 &&
        otpController.text.trim().length < 4) {
      return _showError('Enter the OTP code to complete the transfer.');
    }
    return true;
  }

  bool _showError(String message) {
    Get.snackbar(
      'Check details',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      backgroundColor: AppColor.elevatedSurface(context),
      colorText: AppColor.primaryLabel(context),
      duration: const Duration(seconds: 2),
    );
    return false;
  }

  String get _fromLabel => widget.type == TransferFlowType.betweenAccounts
      ? fromAccount
      : 'Neo Wallet • 1834';

  String get _toLabel {
    if (widget.type == TransferFlowType.betweenAccounts) return toAccount;
    if (widget.type == TransferFlowType.byCardNumber) {
      final digits = cardNumberController.text.replaceAll(' ', '');
      final tail = digits.length >= 4
          ? digits.substring(digits.length - 4)
          : digits;
      return '${cardHolderController.text} • •••• $tail';
    }
    return '${accountTitleController.text} • $selectedBank';
  }
}
