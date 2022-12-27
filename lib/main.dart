import 'package:clean_arch_udemy/crypto_project/presentation/myApp.dart';
import 'package:clean_arch_udemy/crypto_project/provider/encrypt_provider.dart';
import 'package:clean_arch_udemy/crypto_project/provider/register_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => EncryptProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider())
  ], child: MyCryptoApp()));
}
