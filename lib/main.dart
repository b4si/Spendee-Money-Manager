import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/application/category_screen_provider.dart';
import 'package:money_manager/application/formScreenProvider.dart';
import 'package:money_manager/application/home_provider.dart';
import 'package:money_manager/application/statics_screen_provider.dart';
import 'package:money_manager/application/transaction_screen_provider.dart';
import 'package:money_manager/screens/splash_screen.dart';
import 'package:money_manager/transaction_model/transaction_model.dart';
import 'package:provider/provider.dart';
import 'catagory_model/category_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => HomeProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => CategoryScreenProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => FromScreenProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => TransactionScreenProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => StaticsScreenProvider()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
