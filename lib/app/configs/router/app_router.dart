import 'package:go_router/go_router.dart';

import '../../domain/models/cat_breeds_model.dart';
import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/splash_screen',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details_screen',
      name: DetailsScreen.name,
      builder: (context, state) {
        CatModel cat = state.extra as CatModel;
        return DetailsScreen(cat: cat);
      },
    ),
    GoRoute(
      path: '/splash_screen',
      name: SplashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
