# Banking App UI

A Flutter banking app concept focused on polished mobile finance flows, including a revealable dashboard, money transfers, utility payments, card details, and profile-based appearance controls.

## Features

- Revealable home dashboard with balance visibility states
- Financial overview sections for cards, quick actions, spending, cashback, savings, loans, deposits, and history
- Card details screens with spending insights, payment summary, autopay messaging, and account information
- Transfer flow for:
  - between accounts
  - by card number
  - by account details
- Dedicated bill payment modules for phone bills, internet & TV, and housing/utilities
- Profile sheet with security, notifications, cards/limits, and appearance settings
- Light mode, dark mode, and system theme support with persistence via `shared_preferences`
- Built with GetX routing and state handling

## App Modules

- `Splash`: entry transition into the app
- `Home`: balance hero, dashboard sections, and card access
- `Payments`: transfer options and bill payment shortcuts
- `Card Details`: card overview, spending, payment info, and account block
- `Phone Bills`: provider selection, amount selection, autopay, and payment action
- `Internet & TV`: subscriber details, provider switching, amount chips, and payment CTA
- `Housing & Utilities`: utility board selection, due amount selection, autopay, and payment CTA
- `Profile`: account options and appearance mode switching

## Tech Stack

- Flutter
- Dart
- GetX
- `shared_preferences`
- `google_fonts`
- `lucide_icons`

## Project Structure

```text
lib/
  app/
    core/
      theme/
      utils/
    modules/
      splash/
      home/
      payments/
      card_details/
      phone_bills/
      internet_tv/
      housing_utilities/
      tabs/
    routes/
  main.dart
```

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio, VS Code, or any Flutter-compatible IDE

### Run Locally

```bash
flutter pub get
flutter run
```

## Notes

- This repository is primarily a UI showcase for a banking experience.
- Data is currently mock/demo data wired into the interface flows.
- Appearance selection is stored locally so the chosen theme persists between launches.
