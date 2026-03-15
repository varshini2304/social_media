# Varsh — Instagram-Style Social UI (Flutter)

A premium, animated Instagram-style mobile UI built in Flutter with glassmorphism, story rings, carousel posts, and rich micro-interactions. This project focuses on polish, interaction design, and clean architecture alignment with typical company evaluation criteria.

## Highlights

- **Highly animated feed**: story ring rotation, elastic scrolling, fade/scale transitions
- **Post interactions**: swipeable carousel, double‑tap like heart burst, save glow
- **Navigation**: Home, Stories, Notifications, Messages, Saved, Profile
- **Loading states**: shimmer skeletons and a stylized loading splash
- **Modern UI**: glassmorphism overlays, soft gradients, rounded cards, soft shadows

## Feature Coverage (Company Expectations)

- **Separation of concerns** (models, repository, provider, widgets, screens, utils)
- **State management** with `provider`
- **Reusable UI components** (post card, shimmer, story widget, carousel)
- **Navigation flows** for stories, messages, profile, comments, saved, share sheet
- **Production‑ready UI patterns**: shimmer loading, bottom sheet share, detail screens

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
- Stories
- Notifications
- Messages
- Saved (All Posts / Collections)
- Profile
- Post Detail
- Comments
- Story Viewer
- Chat Detail

## Animations & Interactions

- Animated story ring gradient
- Double‑tap like with heart burst
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

## Screenshots

Home (`home.png`)  
![Home](assets/screenshots/home.png)

Stories (`stories.png`)  
![Stories](assets/screenshots/stories.png)

Notifications (`notifications.png`)  
![Notifications](assets/screenshots/notifications.png)

Messages (`messages.png`)  
![Messages](assets/screenshots/messages.png)

Saved (`saved.png`)  
![Saved](assets/screenshots/saved.png)

Profile (`profile.png`)  
![Profile](assets/screenshots/profile.png)

Comments (`comments.png`)  
![Comments](assets/screenshots/comments.png)

Story Viewer (`story_viewer.png`)  
![Story Viewer](assets/screenshots/story_viewer.png)

Chat (`chat.png`)  
![Chat](assets/screenshots/chat.png)

## Build APK

```bash
flutter build apk --debug
```

## Notes

- Default theme mode is **Dark**.
- The loading splash is a short animated entry view (approx. 1.4s by default).

## Optional Enhancements

- Persist theme preference with `SharedPreferences`
- Real API integration and pagination
- Comment/like count persistence
