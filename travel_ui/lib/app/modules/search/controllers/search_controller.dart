import 'package:get/get.dart';

class SearchController extends GetxController {
  final RxList<String> recentSearches = <String>[
    'Bali Villas',
    'Santorini Suites',
    'Dubai Downtown',
  ].obs;

  final List<SearchSuggestion> suggestions = const [
    SearchSuggestion(
      title: 'Maldives Overwater Retreat',
      subtitle: 'Crystal lagoon and private deck',
      imageUrl:
          'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?q=80&w=1974&auto=format&fit=crop',
    ),
    SearchSuggestion(
      title: 'Santorini Cliff Escape',
      subtitle: 'Sunset views and whitewashed homes',
      imageUrl:
          'https://images.unsplash.com/photo-1469796466635-455ede028aca?q=80&w=1974&auto=format&fit=crop',
    ),
    SearchSuggestion(
      title: 'Tokyo Skyline Hotel',
      subtitle: 'City lights and modern comfort',
      imageUrl:
          'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?q=80&w=1974&auto=format&fit=crop',
    ),
  ];

  void addRecentSearch(String query) {
    final String value = query.trim();
    if (value.isEmpty) return;

    recentSearches.removeWhere(
      (item) => item.toLowerCase() == value.toLowerCase(),
    );
    recentSearches.insert(0, value);
    if (recentSearches.length > 6) {
      recentSearches.removeRange(6, recentSearches.length);
    }
  }

  void removeRecentSearch(String query) {
    recentSearches.remove(query);
  }
}

class SearchSuggestion {
  final String title;
  final String subtitle;
  final String imageUrl;

  const SearchSuggestion({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}
