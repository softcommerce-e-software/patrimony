import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:patrimony/data/user/user_repository_impl.dart';
import 'package:patrimony/entity/common_value_entity.dart';
import 'package:patrimony/entity/company_entity.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    _firebase(),_hive()
  ]);
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

Future<void> _hive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CompanyEntityAdapter());
  Hive.registerAdapter(CommonValueEntityAdapter());

  await Hive.openBox<CompanyEntity>(companyBox);
  await Hive.openBox<CommonValueEntity>(typeBox);
  await Hive.openBox<CommonValueEntity>(conservationStateBox);
  await Hive.openBox<bool>(userAdminBox);

  var adminBox = Hive.box<bool>(userAdminBox);
  adminBox.clear();
  adminBox.add(false);
}

Future<void> _firebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setDefaults({});
  await remoteConfig.fetchAndActivate();
  // FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
}