# Elevate Music - Flutter Music Streaming App

A modern Flutter mobile application for music streaming with binaural beats, subscription management, and immersive audio experiences.

## Features

### Music & Audio
- **Music Streaming** - High-quality music playback
- **Binaural Beats** - Specialized audio for focus, relaxation, and meditation
- **Audio Equalizer** - Customizable sound settings
- **Background Playback** - Continue listening while using other apps
- **Playlist Management** - Create and manage your music collections

### User Management
- **User Authentication** - Secure login and registration
- **Profile Management** - Customize your user profile
- **Password Recovery** - Email-based password reset
- **User Dashboard** - Personalized music experience

### Subscription System
- **Stripe Integration** - Secure payment processing
- **Multiple Tiers** - Free and Premium subscription plans
- **Subscription Management** - Easy upgrade/downgrade options
- **Payment History** - Track your subscription status

### Additional Features
- **Push Notifications** - Stay updated with new releases
- **Terms & Conditions** - Legal documentation viewer
- **Disclaimer** - Important app information
- **Responsive Design** - Works on mobile, tablet, and desktop
- **Multi-platform** - Android, iOS, Web, Windows, macOS, Linux

## Tech Stack

### Frontend
- **Framework:** Flutter/Dart
- **State Management:** GetX
- **UI Components:** Material Design
- **Audio Player:** Just Audio
- **HTTP Client:** http package
- **Local Storage:** Shared Preferences

### Backend Integration
- **API Server:** Node.js REST API
- **Base URL:** `http://example.com/api`
- **Authentication:** JWT Tokens
- **Payment Processing:** Stripe API

### Key Packages
```yaml
dependencies:
  flutter: sdk
  get: ^4.6.6
  http: ^1.2.2
  flutter_stripe: ^11.5.0
  just_audio: ^0.9.46
  shared_preferences: ^2.3.4
  flutter_dotenv: ^5.2.1
  firebase_messaging: ^15.2.10
  flutter_local_notifications: ^18.0.1
```

## Installation

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Git

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Sridharraj2023/Elevate-music-oct29.git
   cd Elevate-music-oct29
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment variables**
   
   Create a `.env` file in the project root:
   ```env
   API_URL=http://172.234.201.117:5000/api
   STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
   STRIPE_SECRET_KEY=your_stripe_secret_key
   ENVIRONMENT=production
   ```

4. **Run the app**
   ```bash
   # For Android/iOS
   flutter run
   
   # For Web
   flutter run -d chrome
   
   # For Desktop (Windows/macOS/Linux)
   flutter run -d windows  # or macos, linux
   ```

## Project Structure

```
lib/
├── Controller/           # GetX Controllers
│   ├── Auth_Controller.dart
│   ├── BottomBar_Controller.dart
│   ├── Home_Controller.dart
│   ├── Music_Controller.dart
│   ├── Binaural_controller.dart
│   ├── Subscription_Controller.dart
│   └── Equalizer_Controller.dart
├── Model/               # Data models
│   ├── user.dart
│   ├── Song.dart
│   ├── Binaural_category.dart
│   ├── music_item.dart
│   └── Subscription_Tiers.dart
├── View/                # UI screens and widgets
│   ├── Screens/
│   └── Widgets/
├── services/            # Services
│   └── notification_service.dart
├── utils/               # Utilities
│   └── responsive_helper.dart
├── utlis/              # API & helpers
│   ├── api_constants.dart
│   ├── auth_helper.dart
│   └── subscription_error_handler.dart
└── main.dart           # App entry point

assets/
├── audio/              # Audio files
├── images/             # Images and logos
└── legal/              # Legal documents (PDF)
```

## Configuration

### API Configuration

Edit `lib/utlis/api_constants.dart`:
```dart
class ApiConstants {
  static String get apiUrl => dotenv.env['API_URL'] ?? "http://example.com/api";
  static String get publishKey => dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? 'your_key';
}
```

### Environment Variables

The app supports the following environment variables:
- `API_URL` - Backend API base URL
- `STRIPE_PUBLISHABLE_KEY` - Stripe public key
- `STRIPE_SECRET_KEY` - Stripe secret key
- `ENVIRONMENT` - Environment (development/production)

## Build for Production

### Android APK
```bash
flutter build apk --release
```

### iOS App
```bash
flutter build ios --release
```

### Web App
```bash
flutter build web --release
```

### Windows/macOS/Linux
```bash
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

## Security

- JWT token authentication
- Secure API communication
- Encrypted local storage
- Stripe PCI compliance
- Input validation and sanitization

## API Endpoints

### Authentication
- `POST /api/users/` - User registration
- `POST /api/users/auth` - User login
- `POST /api/users/forgot-password` - Password reset request
- `POST /api/users/reset-password/:token` - Reset password

### Music
- `GET /api/music` - Get all music
- `GET /api/music/:id` - Get specific music
- `GET /api/categories` - Get music categories

### Subscription
- `POST /api/subscription/create-payment-intent` - Create payment
- `GET /api/subscription/status` - Get subscription status

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is proprietary software for the Elevate Music application.

## Contact

For support and questions:
- Email: support@elevateintune.com
- GitHub: [Sridharraj2023](https://github.com/Sridharraj2023)

## Acknowledgments

- Flutter team for the amazing framework
- GetX for state management
- Just Audio for audio playback
- Stripe for payment processing

---

**Built with using Flutter**
