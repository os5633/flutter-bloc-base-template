import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_template/app/app.dart';
import 'package:flutter_bloc_base_template/common/common.dart';
import 'package:flutter_bloc_base_template/repository/repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DeviceInfoHelper.init();
  final authenticationRepository = AuthenticationRepository();
  Bloc.observer = AppBlocObserver();

  return runApp(App(authenticationRepository: authenticationRepository));
}
