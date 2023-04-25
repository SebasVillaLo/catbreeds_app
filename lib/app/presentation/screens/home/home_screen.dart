import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../domain/repositories/cat_repository.dart';
import '../../providers/home_provider/home_provider.dart';
import '../../providers/home_provider/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String name = 'home_screen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final CatRepository catRepository = context.read();
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(catRepository: catRepository)..init(),
      builder: (context, _) {
        final HomeProvider homeProvider = context.watch();
        final HomeState state = homeProvider.state;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cat Breeds App'),
          ),
          body: state is HomeLoading
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: homeProvider.cats.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Image.network(
                            'https://cdn2.thecatapi.com/images/${homeProvider.cats[index].referenceImageId}.jpg',
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          ListTile(
                            title: Text(homeProvider.cats[index].name),
                            subtitle:
                                Text(homeProvider.cats[index].description),
                            onTap: () {
                              context.push('/details_screen');
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
