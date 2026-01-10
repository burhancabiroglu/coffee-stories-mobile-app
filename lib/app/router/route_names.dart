final class RouteNames {
  static const splash = '/';
  static const onboarding = '/onboarding';

  static const login = '/login';
  static const register = '/register';

  static const home = '/home';

  static const creditPurchase = '/credits/purchase';
  static const creditsFinished = '/credits/finished';

  // Chat Flow parent route
  static const chatFlow = '/chat';
  // Chat Flow child routes (nested under /chat)
  static const chatCamera = '/chat/camera';
  static const chatPhotoReview = '/chat/photo-review';
  static const chatText = '/chat/text';
  static const chatVoice = '/chat/voice';
  static const chatResult = '/chat/result';

  static const settings = '/settings';

  // Settings child routes
  static const settingsProfile = '/settings/profile';
  static const settingsNotifications = '/settings/notifications';
  static const settingsPrivacy = '/settings/privacy';
  static const settingsHelp = '/settings/help';

  // Settings legal pages
  static const settingsTerms = '/settings/terms';
  static const settingsPrivacyPolicy = '/settings/privacy-policy';
}