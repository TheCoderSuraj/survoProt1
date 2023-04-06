import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/general/providers/data_provider.dart';
import 'package:survo_protv1/core/user/screens/user_home_screen.dart';

import 'core/general/screens/home_screen.dart';
import 'core/superviser/providers/superviser_provider.dart';
import 'core/superviser/screens/map_screen.dart';
import 'core/superviser/screens/super_home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => SupervisorProvider()),
      ],
      child: const SurvoProt1App(),
    ),
  );
}

class SurvoProt1App extends StatefulWidget {
  const SurvoProt1App({super.key});

  @override
  State<SurvoProt1App> createState() => _SurvoProt1AppState();
}

class _SurvoProt1AppState extends State<SurvoProt1App> {
  @override
  void initState() {
    super.initState();
    context.read<SupervisorProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    return const OKToast(
      child: MaterialApp(
        // home: UserHomeScreen(),
        home: SuperHomeScreen(),
        // home: MapScreen(),
      ),
    );
  }
}
