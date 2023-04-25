import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/configs/router/app_router.dart';
import 'app/configs/theme/app_theme.dart';
import 'app/data/repositories_impl/cats_repository_impl.dart';
import 'app/data/services/the_cat_api.dart';
import 'app/domain/repositories/cat_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<CatRepository>(
          create: (_) => CatsRepositoryImpl(
            TheCatApi(),
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cat Breeds App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 2).getTheme(),
    );
  }
}
