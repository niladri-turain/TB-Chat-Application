import 'package:flutter/material.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/auth/screens/otp_verification_screen.dart';
import '../../features/auth/screens/profile_setup_screen.dart';
import '../../features/chats/screens/chats_screen.dart';
import '../../features/chats/screens/new_chat_screen.dart';
import '../../features/chat/screens/chat_screen.dart';
import '../../features/chat/screens/media_viewer_screen.dart';
import '../../features/groups/screens/groups_screen.dart';
import '../../features/groups/screens/create_group_screen.dart';
import '../../features/groups/screens/group_info_screen.dart';
import '../../features/contacts/screens/contacts_screen.dart';
import '../../features/contacts/screens/contact_profile_screen.dart';
import '../../features/profile/screens/my_profile_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/profile/screens/settings_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String register = '/register';
  static const String signIn = '/sign-in';
  static const String otpVerification = '/otp-verification';
  static const String profileSetup = '/profile-setup';
  static const String chats = '/chats';
  static const String newChat = '/new-chat';
  static const String chat = '/chat';
  static const String mediaViewer = '/media-viewer';
  static const String groups = '/groups';
  static const String createGroup = '/create-group';
  static const String groupInfo = '/group-info';
  static const String contacts = '/contacts';
  static const String contactProfile = '/contact-profile';
  static const String myProfile = '/my-profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case AppRoutes.otpVerification:
        return MaterialPageRoute(builder: (_) => const OtpVerificationScreen());
      case AppRoutes.profileSetup:
        return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());
      case AppRoutes.chats:
        return MaterialPageRoute(builder: (_) => const ChatsScreen());
      case AppRoutes.newChat:
        return MaterialPageRoute(builder: (_) => const NewChatScreen());
      case AppRoutes.chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case AppRoutes.mediaViewer:
        return MaterialPageRoute(builder: (_) => const MediaViewerScreen());
      case AppRoutes.groups:
        return MaterialPageRoute(builder: (_) => const GroupsScreen());
      case AppRoutes.createGroup:
        return MaterialPageRoute(builder: (_) => const CreateGroupScreen());
      case AppRoutes.groupInfo:
        return MaterialPageRoute(builder: (_) => const GroupInfoScreen());
      case AppRoutes.contacts:
        return MaterialPageRoute(builder: (_) => const ContactsScreen());
      case AppRoutes.contactProfile:
        return MaterialPageRoute(builder: (_) => const ContactProfileScreen());
      case AppRoutes.myProfile:
        return MaterialPageRoute(builder: (_) => const MyProfileScreen());
      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
