# HarmonyLink  
A simple, aesthetic, community-powered mobile app for sharing anonymous, mood-based playlists.  
Built for DMIT2504 – Mobile Application Development.

---

## Overview  
HarmonyLink lets users express how they feel through short, mood-based playlists.  
No profiles, no likes, no comments. Just music, mood, and community.

Users can:
- Submit anonymous playlists (1–3 songs)
- Select and explore playlists by mood
- Open tracks through Spotify or YouTube
- Customize the app with personal color themes
- Enjoy smooth UI transitions and animations

---

## Purpose  
The app provides:
- A safe, anonymous space to express emotions  
- A simple creative outlet centered on mood and music  
- A visual, aesthetic interface  
- A community-built feed of playlists  

HarmonyLink demonstrates technical depth through Firebase integration, state management, animations, theme handling, and persistent storage.

---

## Tech Stack & Features  

### Core Functionality  
- Mood categories (Calm + Collected, Low Energy, Uplifted, etc.)  
- Anonymous playlist submission (1–3 songs + optional description)  
- Playlist feed exploration  
- Playlist detail view with external links  
- Theme selector with persistent user preferences  
- Animated transitions and clean UI  

### Additional Features  
- Custom typography via Google Fonts  
- Optional daily playlist notifications  
- Offline caching  

---


**Presentation Layer**  
- Screens and widgets  
- UI stored and updated through Providers  
- Theme switching

**Business Logic Layer**  
- Providers and view models  
- Playlist fetching, validation, and submission

**Data Layer**  
- Firebase Authentication (anonymous sign-in)  
- Firestore playlist collection  
- SharedPreferences for theme persistence  

---



