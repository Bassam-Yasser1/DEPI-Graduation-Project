import 'dart:io';

import 'package:depi_graduation_project/core/database/tourApp_database.dart';
import 'package:depi_graduation_project/core/utilities/assets.dart';
import 'package:depi_graduation_project/features/auth/controllers/login_controller.dart';
import 'package:depi_graduation_project/features/auth/presentation/views/login_view.dart';
import 'package:depi_graduation_project/features/auth/controllers/register_controller.dart';
import 'package:depi_graduation_project/features/auth/presentation/views/register_view.dart';
import 'package:depi_graduation_project/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'core/services/api_services/api_services.dart';
import 'features/home/controllers/home_controller.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1) انسخ قاعدة البيانات لأول مرة
  await copyDatabase();

  // 2) افتح قاعدة البيانات بعد النسخ
  database = await $FloortourDatabase
      .databaseBuilder('tourAppDB.db')
      .build();
  runApp(const MyApp());
}
late tourDatabase database;

Future<void> copyDatabase() async {
  // 1) المسار اللي هتتخزن فيه القاعدة
  final dbDir = await getDatabasesPath();
  final dbPath = join(dbDir, 'tourAppDB.db');

  // 2) لو الملف موجود → خلاص
  if (File(dbPath).existsSync()) {
    print("Database already exists");
    return;
  }

  print("Copying database...");

  // 3) اقرأ ملف db من الـassets
  ByteData data = await rootBundle.load(Assets.databaseAsset);

  // 4) حوله لـ List<int>
  List<int> bytes =
  data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  // 5) اكتب ملف جديد في المسار
  await File(dbPath).create(recursive: true);
  await File(dbPath).writeAsBytes(bytes, flush: true);

  print("Database copied!");
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 924),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          initialBinding: BindingsBuilder(() {
            Get.lazyPut(() => ApiServices());
          }),
          getPages: [
            GetPage(
              name: '/home',
              page: () => const HomePage(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => HomeController());
              }),
            ),
            GetPage(
              name: '/login',
              page: () => const LoginView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => LoginController());
              }),
            ),
            GetPage(
              name: '/register',
              page: () => const RegisterView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => RegisterController());
              }),
            ),
          ],
        );
      },
    );
  }
}
