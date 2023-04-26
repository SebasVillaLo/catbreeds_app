import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/configs/router/app_router.dart';
import 'app/data/repositories_impl/cats_repository_impl.dart';
import 'app/data/services/the_cat_api.dart';
import 'app/domain/repositories/cat_repository.dart';
import 'app/presentation/providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<CatRepository>(
          create: (_) => CatsRepositoryImpl(
            TheCatApi(),
          ),
        ),
        Provider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = context.watch<ThemeProvider>();
        return MaterialApp.router(
          title: 'Cat Breeds App',
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
          theme: themeProvider.theme,
        );
      },
    );
  }
}
