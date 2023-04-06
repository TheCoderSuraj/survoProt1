import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/general/providers/data_provider.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/core/superviser/screens/user_details_screen.dart';
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
    return OKToast(
      child: MaterialApp(
        // home: UserHomeScreen(),
        home: SuperHomeScreen(),
        //     home: UserDetailsScreen(
        //   am: AccountModel(
        //     id: "2458",
        //     name: "see",
        //     baseLocation: LocationModel(lat: 123.12, lon: 32.32),
        //     allowedDistance: 200,
        //     lastLoc: LatLng(123.01, 32.22),
        //   ),
        // )
        // home: MapScreen(),
      ),
    );
  }
}
