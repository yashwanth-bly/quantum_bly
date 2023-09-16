import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepository(),
      child: GlobalLoaderOverlay(
        overlayOpacity: 0.5,
        overlayColor: Colors.brown.withOpacity(0.5),
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: Text(
            'Loading...',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: MaterialApp(
          title: 'Quantum',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            primaryColor: Colors.blueGrey,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              color: Colors.white70,
            ),
          ),
          home: BlocProvider<SplashCubit>(
            create: (context) => SplashCubit(
              authRepository: context.read<AuthRepository>(),
            )..load(),
            child: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
