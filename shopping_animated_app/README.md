# Aurora Music App

A modern Flutter music UI demo with glassmorphism styling, fluid animations, and an interactive player experience.

## Overview

This app focuses on high-quality motion and polished visual details:

- Animated splash with glass icon treatment
- Dashboard with category chips, featured cards, and animated bottom navigation
- Player screen with animated artwork carousel, modern seek controls, and glass surfaces
- Network audio playback with seek, next/previous, shuffle/repeat, and reactive visual accents

## Key Features

- `GetX` navigation and state management
- Glass UI layers using `liquid_glass_renderer`
- Water ripple tap interactions across controls
- Animated transitions for cards, cover carousel, and controls
- Custom player layout with:
- Slider seek bar
- In-card elapsed and total duration labels
- Up Next card section
- Ambient animated glow background
- Mini animated gradient waveform strip
- Streaming playback with `just_audio`
- Beat-accent visual response using waveform extraction (`just_waveform`)

## Animation Highlights

- Glass icon pulse on splash
- Ripple feedback on tap targets
- Active player artwork emphasis during playback
- Background glow and waveform motion that react to playback state

## Tech Stack

- Flutter
- Dart
- GetX
- just_audio
- just_waveform
- liquid_glass_renderer

## Getting Started

### Prerequisites

- Flutter SDK installed and configured
- iOS or Android toolchain configured

### Install

```bash
flutter pub get
```

### Run

```bash
flutter run
```

## Project Structure

- `lib/app/modules/splash`: splash screen UI and startup flow
- `lib/app/modules/dashboard`: home/library/settings and animated navigation
- `lib/app/modules/player`: player controller, UI, and playback interactions
- `lib/app/core/widgets`: reusable interaction widgets (including ripple tap)
- `lib/app/core/theme`: shared colors and visual tokens

## Notes

- Demo tracks use network image/audio URLs.
- First-time beat analysis for a track may take a short moment while waveform data is prepared and cached.
