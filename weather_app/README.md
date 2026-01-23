# SkyPulse

SkyPulse is a modern Flutter weather experience with animated sky scenes,
glassmorphism UI, and rich forecast detail. It uses OpenWeatherMap and supports
dynamic day/night themes, smooth motion, and a clean GetX architecture.

## Highlights
- Dynamic animated weather backgrounds (clear, clouds, rain, snow, fog, storm)
- Glass UI cards with modern motion
- Hourly forecast curve with temperature gradient
- 7-day forecast with expandable cards
- Location search + saved cities (Hive)
- Light/dark theme based on sun position

## Tech Stack
- Flutter (Material 3)
- GetX (routing/state)
- OpenWeatherMap API
- Hive (local storage)

## Setup
1. Add your OpenWeatherMap key in `.env`:
   ```env
   WEATHER_API_KEY=YOUR_KEY
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run:
   ```bash
   flutter run
   ```

## Project Structure
```
lib/
  app/
    data/
    modules/
    routes/
    theme/
    utils/
    widgets/
```

## Notes
- The app name and package ID are set to `SkyPulse` and `com.usman1170.skypulse`.
- Icons are generated and stored in platform-specific folders; update `assets/logo.png`
  if you want a new brand mark.
