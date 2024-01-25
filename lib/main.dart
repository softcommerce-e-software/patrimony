import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'firebase_options.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  await Future.wait([_firebase(), _supabase()]);
  FlutterNativeSplash.remove();

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

Future<void> _firebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setDefaults({});
  await remoteConfig.fetchAndActivate();
  return;
}

Future<void> _supabase() async {
  await Supabase.initialize(
    url: 'https://ihxnlxsqtrdzzopqfiwn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImloeG5seHNxdHJkenpvcHFmaXduIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDUwNzEyMDIsImV4cCI6MjAyMDY0NzIwMn0.IIoAknwmZcuoA6t_9ubtxVPGJUHK_2DCOzNIWpdWWUQ',
  );

  return;
}
