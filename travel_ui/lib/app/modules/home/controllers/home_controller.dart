import 'package:get/get.dart';

class HomeController extends GetxController {
  final String heroImage =
      'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1400&q=80';

  final List<FeaturedOffer> offers = const [
    FeaturedOffer(
      title: 'Luxury in Bali',
      subtitle: 'Unwind where paradise meets comfort.',
      imageUrl:
          'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?auto=format&fit=crop&w=1200&q=80',
      priceTag: '\$120/night',
    ),
    FeaturedOffer(
      title: 'A Touch of Rome',
      subtitle: 'Where elegance welcomes every stay.',
      imageUrl:
          'https://images.unsplash.com/photo-1576675784201-0e142b423952?auto=format&fit=crop&w=1000&q=80',
      priceTag: '\$95/night',
    ),
  ];
}

class FeaturedOffer {
  const FeaturedOffer({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.priceTag,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final String priceTag;
}
