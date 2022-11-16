import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_absen/services/services.dart';
import 'package:provider/provider.dart';
import 'package:go_absen/common/common.dart';
import 'package:go_absen/screens/screens.dart';
import 'package:go_absen/utils/utils.dart';
import 'package:go_absen/provider/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  OneSignal.shared.init(oneSignalAppID, iOSSettings: null);
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ValidationProvider()),
          ChangeNotifierProvider(create: (_) => PresenceProvider()),
          ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ],
        child: MaterialApp(
          title: "GoAbsen",
          home: SplashScreen(),
          theme: appTheme,
          routes: appRoute,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
        ),
      ),
    );
  }
}
