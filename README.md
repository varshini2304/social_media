# Varsh — Instagram-Style Social UI (Flutter)

Premium, animated Instagram‑style UI built with Flutter. The focus is on **polish**, **interaction design**, and **clean architecture**, matching what most companies expect in a take‑home or UI assignment.

## Highlights

- Animated feed with story ring gradients and smooth micro‑interactions
- Swipeable post carousel + hero image transitions
- Double‑tap like with heart burst
- Glowing save button + shimmer loading states
- Glassmorphism overlays, soft gradients, rounded cards, soft shadows
- Dark mode default with light mode support

## What This Project Demonstrates (Company Expectations)

- **Clean architecture**: clear separation of models, data, state, widgets, and screens
- **State management**: `provider` with testable logic
- **Reusable components**: story widget, post card, shimmer, carousel, buttons
- **Navigation flows**: stories, profile, comments, messages, saved, share sheet
- **Production‑ready patterns**: shimmer loading, modal sheets, detail screens

## Architecture

```
lib/
  models/
  repositories/
  providers/
  services/
  widgets/
  screens/
  utils/
  main.dart
```

## Core Screens

- Home Feed
- Stories + Story Viewer
- Notifications
- Messages + Chat Detail
- Saved (All Posts / Collections)
- Profile
- Post Detail
- Comments

## Animations & Interactions

- Animated story ring gradient
- Double‑tap like + heart burst
- Swipeable image carousel
- Hero transition into image detail
- Glowing save button
- Shimmer loading placeholders

## Tech Stack

- **Flutter** (Material 3)
- **Provider** for state management
- **Google Fonts** for typography

## Run Locally

```bash
flutter pub get
flutter run
```

## Build APK

```bash
flutter build apk --debug
```

## Screenshots

| Loading | Home | Stories |
| --- | --- | --- |
| ![Loading](assets/screenshots/loading_page.png) | ![Home](assets/screenshots/home_page.png) | ![Stories](assets/screenshots/stories.png) |
| Story Viewer | Notifications | Messages |
| ![Story Viewer](assets/screenshots/Story_page.png) | ![Notifications](assets/screenshots/notifications.png) | ![Messages](assets/screenshots/messages.png) |
| Chat | Saved | Profile |
| ![Chat](assets/screenshots/chat.png) | ![Saved](assets/screenshots/saved_items.png) | ![Profile](assets/screenshots/profile.png) |
| Comments | Like Button |  |
| ![Comments](assets/screenshots/comments.png) | ![Like Button](assets/screenshots/Like_button.png) |  |

## Notes

- Default theme mode is **Dark**.
- Loading splash duration: ~1.4 seconds (configurable).

## Optional Enhancements

- Persist theme preference with `SharedPreferences`
- Real API integration and pagination
- Comment/like count persistence
