# Travel UI

A Flutter travel booking UI built with GetX. The app ships with a polished multi-tab flow for discovering stays, reviewing offers, browsing bookings, and viewing a profile dashboard.

## Overview

This project is a UI-focused travel app prototype with mock data and network images. It includes:

- A floating bottom tab bar for `Home`, `Search`, `Bookings`, and `Profile`
- A featured travel landing screen with highlighted hotel offers
- Offer details pages with hero animations, gallery, facilities, and stay highlights
- A search screen with recent searches and destination suggestions
- A bookings screen with a swipeable monthly calendar and booking cards
- A booking details screen with trip timeline and amenities
- A profile screen with stats, segmented tabs, and account/settings sections

## Tech Stack

- Flutter
- Dart
- GetX for routing, dependency binding, and reactive state
- Material 3

## Project Structure

```text
lib/
  app/
    core/
      theme/
      utils/
      widgets/
    modules/
      bookings/
      booking_details/
      home/
      offer_details/
      profile/
      search/
      tabs/
    routes/
  main.dart
```

## Screens

### Home

- Personalized header
- Large hero-style featured card
- Horizontal featured offers list
- Additional browse cards for premium stays

### Search

- Search input UI
- Recent search chips with add/remove behavior
- Curated destination suggestions

### Bookings

- Interactive month calendar
- Booking status cards such as `Confirmed`, `Upcoming`, and `Pending`
- Navigation into booking detail view

### Offer Details

- Large image header with hero transition
- Save/bookmark toggle
- Pricing, description, facilities, gallery, and highlights

### Booking Details

- Stay summary card
- Trip timeline
- Expandable amenities section

### Profile

- User summary and travel stats
- Segmented sections for settings, account, and plans

## State and Data

- The app currently uses local mock data inside controllers and widgets
- Images are loaded from remote Unsplash URLs
- No backend or persistence layer is connected yet

## Getting Started

### Prerequisites

- Flutter SDK installed
- Dart SDK included with Flutter
- An emulator, simulator, or connected device

### Run the App

```bash
flutter pub get
flutter run
```

## Main Entry

The app starts from `lib/main.dart` and uses `GetMaterialApp` with `TabsView` as the initial route.

## Notes

- The visual design uses a custom soft green gradient scaffold shared across major screens
- Navigation is organized through GetX route bindings in `lib/app/routes`
- This repository is best suited as a travel app UI reference or starter for a fuller booking product
