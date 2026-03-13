import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static const Color white = Color(0xFFFFFFFF);
  static const Color scaffoldBg = Color(0xFFF5F5F7);
  static const Color primaryText = Color(0xFF1A1A2E);
  static const Color secondaryText = Color(0xFF6B7280);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color cardDark = Color(0xFF1E1E2E);
  static const Color cardLightBlue = Color(0xFFE0F0FF);
  static const Color cardLightGreen = Color(0xFFE0F5E4);
  static const Color bottomNavActive = Color(0xFF3B82F6);
  static const Color bottomNavInactive = Color(0xFF9CA3AF);
  static const Color redBadge = Color(0xFFEF4444);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color spendingPurple = Color(0xFFEDE9FE);
  static const Color spendingPurpleIcon = Color(0xFF7C3AED);
  static const Color spendingBlue = Color(0xFFDBEAFE);
  static const Color spendingBlueIcon = Color(0xFF3B82F6);
  static const Color spendingGreen = Color(0xFFD1FAE5);
  static const Color spendingGreenIcon = Color(0xFF10B981);
  static const Color creditCardGradientStart = Color(0xFFFFFFFF);
  static const Color creditCardGradientEnd = Color(0xFFDFF0FE);
  static const Color debitCardGradientStart = Color(0xFFFFFFFF);
  static const Color debitCardGradientEnd = Color(0xFFE2F6E7);
  static const Color savingsGradientStart = Color(0xFFE0F2FE);
  static const Color savingsGradientEnd = Color(0xFFBAE6FD);
  static const Color greyBg = Color(0xFFF3F4F6);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color cardStarYellow = Color(0xFFFBBF24);
  static const Color masterCardRed = Color(0xFFEB001B);
  static const Color masterCardOrange = Color(0xFFF79E1B);
  static const Color surfaceSoft = Color(0xFFF5F5F7);
  static const Color surfaceMuted = Color(0xFFF1F2F4);
  static const Color surfaceLavender = Color(0xFFE8ECFA);
  static const Color surfaceMint = Color(0xFFDEF2EE);
  static const Color textStrong = Color(0xFF16181D);
  static const Color textMuted = Color(0xFF7B7C80);
  static const Color textMid = Color(0xFF2A2D33);
  static const Color paymentsBlue = Color(0xFF4F97EA);
  static const Color paymentsBlueSoft = Color(0xFFBFDFFF);
  static const Color paymentsBlueCard = Color(0xFF7EBBFA);
  static const Color paymentsMint = Color(0xFF56C5AA);
  static const Color badgeRed = Color(0xFFFF4D57);
  static const Color iconDark = Color(0xFF23262B);
  static const Color iconGrey = Color(0xFFABACB0);
  static const Color splashStart = Color(0xFFEAF5FF);
  static const Color splashEnd = Color(0xFFB8DEFF);
  static const Color splashCard = Color(0xFF5EA9F7);
  static const Color splashCardSoft = Color(0xFFD9ECFF);
  static const Color splashInk = Color(0xFF20324A);
  static const Color homeBg = Color(0xFFF7F7F8);
  static const Color heroGlow = Color(0xFF66E5F5);
  static const Color heroCircle = Color(0xFFFFFFFF);
  static const Color heroCircleShadow = Color(0x22000000);
  static const Color surfaceSheet = Color(0xFFFDFDFD);
  static const Color overlayScrim = Color(0x220F172A);
  static const Color successGreen = Color(0xFF29B45A);
  static const Color warningOrange = Color(0xFFFFA94D);
  static const Color profileBlue = Color(0xFFE8F1FF);
  static const Color pageBlueTop = Color(0xFFF4FBFF);
  static const Color pageBlueBottom = Color(0xFFDFF2FF);
  static const Color pageGreenTop = Color(0xFFF5FCF6);
  static const Color pageGreenBottom = Color(0xFFE4F7E7);
  static const Color mutedBorder = Color(0xFFD6D9DE);

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color screenBackground(BuildContext context) =>
      isDark(context) ? const Color(0xFF232427) : homeBg;

  static Color elevatedSurface(BuildContext context) =>
      isDark(context) ? const Color(0xFF2B2E34) : white;

  static Color softSurface(BuildContext context) =>
      isDark(context) ? const Color(0xFF31343B) : surfaceSoft;

  static Color mutedSurface(BuildContext context) =>
      isDark(context) ? const Color(0xFF3A3D44) : surfaceMuted;

  static Color sheetSurface(BuildContext context) =>
      isDark(context) ? const Color(0xFF292C31) : surfaceSheet;

  static Color primaryLabel(BuildContext context) =>
      isDark(context) ? const Color(0xFFF4F5F7) : textStrong;

  static Color secondaryLabel(BuildContext context) =>
      isDark(context) ? const Color(0xFFB7BCC6) : secondaryText;

  static Color tertiaryLabel(BuildContext context) =>
      isDark(context) ? const Color(0xFF939AA8) : iconGrey;

  static Color dividerColor(BuildContext context) =>
      isDark(context) ? const Color(0xFF454A54) : divider;

  static Color navInactive(BuildContext context) =>
      isDark(context) ? const Color(0xFF969CAA) : bottomNavInactive;

  static Color overlay(BuildContext context) =>
      isDark(context) ? const Color(0xAA090B10) : overlayScrim;

  static Color blueSoft(BuildContext context) =>
      isDark(context) ? const Color(0xFF223748) : paymentsBlueSoft;

  static Color mintSoft(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F3B36) : surfaceMint;

  static Color lavenderSoft(BuildContext context) =>
      isDark(context) ? const Color(0xFF343244) : surfaceLavender;

  static Color heroGlowColor(BuildContext context) =>
      isDark(context) ? const Color(0xFF2DE0FF) : heroGlow;

  static Color heroOrb(BuildContext context) =>
      isDark(context) ? const Color(0xFF4A4A4D) : heroCircle;

  static Color heroShadow(BuildContext context) =>
      isDark(context) ? const Color(0x5500D7FF) : heroCircleShadow;

  static List<Color> splashGradient(BuildContext context) => isDark(context)
      ? const [Color(0xFF171A20), Color(0xFF20242D)]
      : const [splashStart, splashEnd];

  static List<Color> savingsCardGradient(BuildContext context) =>
      isDark(context)
      ? const [Color(0xFF19364A), Color(0xFF24506B)]
      : const [Color(0xFFBFE6FF), Color(0xFFA7DCFF)];

  static List<Color> bankCardGradient(
    BuildContext context, {
    required bool isCredit,
  }) {
    if (!isDark(context)) {
      return isCredit
          ? const [
              creditCardGradientStart,
              creditCardGradientEnd,
              creditCardGradientEnd,
            ]
          : const [
              debitCardGradientStart,
              debitCardGradientEnd,
              debitCardGradientEnd,
            ];
    }

    return isCredit
        ? const [Color(0xFF1F2835), Color(0xFF264761), Color(0xFF1F2835)]
        : const [Color(0xFF1F2A29), Color(0xFF28524A), Color(0xFF1F2A29)];
  }

  static List<Color> detailsPageGradient(
    BuildContext context, {
    required bool isCredit,
  }) {
    if (!isDark(context)) {
      return isCredit
          ? [pageBlueTop, pageBlueBottom, white.withAlpha(248), white]
          : [pageGreenTop, pageGreenBottom, white.withAlpha(248), white];
    }

    return isCredit
        ? const [
            Color(0xFF151B22),
            Color(0xFF192A36),
            Color(0xFF20242A),
            Color(0xFF232427),
          ]
        : const [
            Color(0xFF151B1A),
            Color(0xFF19322C),
            Color(0xFF202524),
            Color(0xFF232427),
          ];
  }
}
