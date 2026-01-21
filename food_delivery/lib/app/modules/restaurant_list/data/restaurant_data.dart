class Product {
  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.eta,
    required this.products,
  });

  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String eta;
  final List<Product> products;
}

class BannerItem {
  BannerItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
}

final List<BannerItem> demoBanners = [
  BannerItem(
    title: 'Friday Feast',
    subtitle: 'Save 20% on smoky grills',
    imageUrl:
        'https://images.unsplash.com/photo-1526318896980-cf78c088247c?auto=format&fit=crop&w=1400&q=80',
  ),
  BannerItem(
    title: 'Chef Specials',
    subtitle: 'Handpicked new menu drops',
    imageUrl:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1400&q=80',
  ),
  BannerItem(
    title: 'Dessert After Dark',
    subtitle: 'Indulgent bites, fast',
    imageUrl:
        'https://images.unsplash.com/photo-1504387432042-8aca549e4729?auto=format&fit=crop&w=1400&q=80',
  ),
];

final List<Restaurant> demoRestaurants = [
  _buildRestaurant(
    id: 'r1',
    name: 'Ember & Oak',
    imageUrl:
        'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=1400&q=80',
    rating: 4.8,
    eta: '25-30 min',
  ),
  _buildRestaurant(
    id: 'r2',
    name: 'Saffron Table',
    imageUrl:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1400&q=80',
    rating: 4.6,
    eta: '20-25 min',
  ),
  _buildRestaurant(
    id: 'r3',
    name: 'Midnight Ramen',
    imageUrl:
        'https://images.unsplash.com/photo-1473093226795-af9932fe5856?auto=format&fit=crop&w=1400&q=80',
    rating: 4.7,
    eta: '30-35 min',
  ),
  _buildRestaurant(
    id: 'r4',
    name: 'Citrus & Salt',
    imageUrl:
        'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=1400&q=80',
    rating: 4.5,
    eta: '15-20 min',
  ),
  _buildRestaurant(
    id: 'r5',
    name: 'Nordic Bites',
    imageUrl:
        'https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?auto=format&fit=crop&w=1400&q=80',
    rating: 4.4,
    eta: '20-30 min',
  ),
];

Restaurant _buildRestaurant({
  required String id,
  required String name,
  required String imageUrl,
  required double rating,
  required String eta,
}) {
  final productImages = [
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1481931098730-318b6f776db0?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1421622548261-c45bfe178854?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1506089676908-3592f7389d4d?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1470337458703-46ad1756a187?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=1200&q=80',
    'https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?auto=format&fit=crop&w=1200&q=80',
  ];

  final products = List.generate(10, (index) {
    final number = index + 1;
    return Product(
      id: '${id}_p$number',
      name: 'Signature Dish $number',
      imageUrl: productImages[index % productImages.length],
      description:
          'Smoky, bright, and layered with fresh herbs. Built for a satisfying bite.',
      price: 9.5 + index * 1.2,
    );
  });

  return Restaurant(
    id: id,
    name: name,
    imageUrl: imageUrl,
    rating: rating,
    eta: eta,
    products: products,
  );
}
