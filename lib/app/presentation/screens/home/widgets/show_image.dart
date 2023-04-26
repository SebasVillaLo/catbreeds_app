import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({
    super.key,
    required this.urlImage,
  });
  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 200),
            image: NetworkImage(
              urlImage,
            ),
            placeholder: const AssetImage(
              'assets/images/jar-loading.gif',
            ),
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
            imageErrorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Image.network(
                urlImage.replaceAll('jpg', 'png'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              );
            },
          ),
        ),
      ),
    );
  }
}
