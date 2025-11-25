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
import 'bloc/auth_bloc.dart';
import 'bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          '/homepage': (context) => const HomepageScreen(),
          '/jobs': (context) => const JobsScreen(),
          '/volunteer': (context) => const VolunteerScreen(),
          '/explore': (context) => const ExploreScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
