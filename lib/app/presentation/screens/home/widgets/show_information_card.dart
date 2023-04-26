import 'package:flutter/material.dart';

import '../../../../domain/models/cat_breeds_model.dart';

class ShowInformationCard extends StatelessWidget {
  const ShowInformationCard({
    super.key,
    required this.cat,
  });
  final CatModel cat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 20),
      child: ListTile(
        title: Text(cat.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ItemsCard(
              labelTextOne: 'Origin: ${cat.origin} ',
              labelTextTwo: 'Life span: ${cat.lifeSpan} years',
            ),
            _ItemsCard(
              labelTextOne: 'Temperamento: ${cat.temperament} ',
              labelTextTwo: 'Social needs: ${cat.socialNeeds}/5 ',
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemsCard extends StatelessWidget {
  const _ItemsCard({
    required this.labelTextOne,
    required this.labelTextTwo,
  });

  final String labelTextOne;
  final String labelTextTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            labelTextOne,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            labelTextTwo,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
