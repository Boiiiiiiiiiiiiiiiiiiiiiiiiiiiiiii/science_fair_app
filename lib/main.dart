import 'package:flutter/material.dart';
import 'package:science_fair_app/data/classes/user_info_class.dart';
import 'package:science_fair_app/data/notifiers.dart';
import 'package:science_fair_app/views/widget_tree.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:science_fair_app/data/classes/debt.dart';  // Import your Debt class
void main() async {
  await Hive.initFlutter(); 
  Hive.registerAdapter(DebtAdapter());
  Hive.registerAdapter(DebtTypeAdapter());
  Hive.registerAdapter(UserInfoAdapter());

  await Hive.openBox<Debt>('debts');
  await Hive.openBox<UserInfo>('userInfo');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Box<UserInfo> userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = Hive.box('userInfo');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkThemeNotifier,
      builder: (context, isDark, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: isDark ? Brightness.dark : Brightness.light
            )
          ),

          home: WidgetTree()
        );
      },
    );
  }
}
