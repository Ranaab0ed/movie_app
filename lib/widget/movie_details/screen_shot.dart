import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class CustomScreenShot extends StatelessWidget {
  final String image;
  const CustomScreenShot({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        imageUrl: image,
        height: h * 0.2,
        width: w,
        fit: BoxFit.cover,
      ),
    );
  }
}
