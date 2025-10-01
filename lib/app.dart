import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:mil/features/auth/data/firebase_auth_repo.dart';
import 'package:mil/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mil/features/auth/presentation/cubits/auth_states.dart';
import 'package:mil/features/profile/data/firebase_profile_repo.dart';
import 'package:mil/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:mil/themes/theme.dart';
import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final profileRepo = FirebaseProfileRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(profileRepo: profileRepo),
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: themeProvider?.currentTheme,
              home: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, authState) {
                  if (authState is Unauthenticated) {
                    return const AuthPage();
                  } else if (authState is Authenticated) {
                    return const HomePage();
                  } else {
                    return Scaffold(
                      backgroundColor: themeProvider?.isDarkMode ?? false
                          ? darkMode.scaffoldBackgroundColor
                          : lightMode.scaffoldBackgroundColor,
                      body: Center(
                        child: Lottie.asset(
                          'assets/animations/loading.json', // make sure this exists
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
