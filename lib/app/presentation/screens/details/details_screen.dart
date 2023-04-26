import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/cat_breeds_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.cat});
  final CatModel cat;
  static const String name = 'details_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  cat.urlImage,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                // padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: theme.colorScheme.primaryContainer,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ItemsDescription(
                        title: 'Description',
                        subTitle: cat.description,
                      ),
                      _ItemsDescription(
                        title: 'Temperament',
                        subTitle: cat.temperament,
                      ),
                      _ItemsDescription(
                        title: 'Origin',
                        subTitle: cat.origin,
                      ),
                      _ItemsDescription(
                        title: 'Life Span',
                        subTitle: cat.lifeSpan,
                      ),
                      _ItemsDescription(
                        title: 'Adaptability',
                        subTitle: cat.adaptability.toString(),
                      ),
                      _ItemsDescription(
                        title: 'Affection Level',
                        subTitle: cat.affectionLevel.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ItemsDescription extends StatelessWidget {
  const _ItemsDescription({
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        const SizedBox(
          height: 5,
        ),
        Text(
          subTitle,
          style: theme.textTheme.displayMedium,
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
