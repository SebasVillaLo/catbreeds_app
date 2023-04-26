import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../configs/theme/app_theme.dart';
import '../../../domain/models/cat_breeds_model.dart';
import '../../../domain/repositories/cat_repository.dart';
import '../../providers/home_provider/home_provider.dart';
import '../../providers/home_provider/home_state.dart';
import '../../providers/theme_provider.dart';
import 'widgets/show_image.dart';
import 'widgets/show_information_card.dart';
import 'widgets/toggle_switcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String name = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final CatRepository catRepository = context.read();
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(catRepository: catRepository)..init(),
      builder: (context, _) {
        final HomeProvider homeProvider = context.watch();
        final HomeState state = homeProvider.state;
        final ThemeProvider themeProvider = context.watch();
        return Scaffold(
          drawer: _Drawer(theme: theme, themeProvider: themeProvider),
          appBar: AppBar(
            title: const Text('Cat Breeds App'),
            actions: [
              IconButton(
                onPressed: () {
                  final isSearching = homeProvider.isSearching;

                  isSearching
                      ? homeProvider.setSearching(false)
                      : homeProvider.setSearching(true);
                },
                icon: homeProvider.isSearching
                    ? const Icon(Icons.close_rounded)
                    : const Icon(Icons.search),
              ),
            ],
            bottom: homeProvider.isSearching
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(48.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        focusNode: homeProvider.focusNode,
                        onTapOutside: (_) => homeProvider.unFoucs(),
                        controller: homeProvider.searchController,
                        decoration: const InputDecoration(
                          hintText: 'Buscar',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: state is HomeLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: homeProvider.scrollController,
                    key: const PageStorageKey('home_screen_list'),
                    itemCount: homeProvider.cats.length,
                    itemBuilder: (context, index) {
                      final CatModel cat = homeProvider.cats[index];
                      return GestureDetector(
                        onTap: () => context.push(
                          '/details_screen',
                          extra: cat,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 5),
                          child: Card(
                            color: colors.primaryContainer,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShowImage(urlImage: cat.urlImage),
                                ShowInformationCard(
                                  cat: cat,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: homeProvider.isBottom
              ? FloatingActionButton(
                  onPressed: homeProvider.upToTop,
                  backgroundColor: colors.secondaryContainer,
                  child: homeProvider.isLoading
                      ? SpinPerfect(
                          infinite: true,
                          child: const Icon(Icons.refresh_rounded),
                        )
                      : FadeIn(
                          child: const Icon(Icons.arrow_upward),
                        ),
                )
              : null,
        );
      },
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    required this.theme,
    required this.themeProvider,
  });

  final ThemeData theme;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Theme',
                style: theme.textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ExpansionTile(
              title: const Text('Select color'),
              children: [
                Wrap(
                  children: List.generate(
                    colorList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => themeProvider.setThemeColor(index),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: colorList[index],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Text('Dark mode'),
                  Spacer(),
                  ToggleSwitcher(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
