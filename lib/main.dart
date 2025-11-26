import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/homepage_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/jobs_screen.dart';
import 'screens/volunteer_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/my_activity_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/home_bloc.dart';
import 'bloc/jobs_bloc.dart';
import 'bloc/jobs_event.dart';

import 'firebase_options.dart';

import 'services/seeding_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✓ Firebase initialized successfully');
    print('  Project ID: ${DefaultFirebaseOptions.currentPlatform.projectId}');
    print('  App ID: ${DefaultFirebaseOptions.currentPlatform.appId}');
  } catch (e, stackTrace) {
    print('✗ Firebase initialization failed: $e');
    print('Stack trace: $stackTrace');
  }

  // Seed dummy data (safe to call multiple times as it checks for existence)
  await SeedingService().seedAll();

  runApp(const ZambiConnectApp());
}

class ZambiConnectApp extends StatelessWidget {
  const ZambiConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => JobsBloc()..add(LoadJobsEvent())),
      ],
      child: MaterialApp(
        title: 'ZambiConnect',
        theme: ThemeData(
          primaryColor: const Color(0xFF2E7D32),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xFF333333)),
            titleTextStyle: TextStyle(
              color: Color(0xFF333333),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/homepage': (context) => const HomepageScreen(),
          '/jobs': (context) => const JobsScreen(),
          '/volunteer': (context) => const VolunteerScreen(),
          '/explore': (context) => const ExploreScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/my-activity': (context) => const MyActivityScreen(),
          '/edit-profile': (context) => const EditProfileScreen(),
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
