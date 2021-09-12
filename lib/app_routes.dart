import 'package:movie_helper/features/discovery/presentation/page/discovery.page.dart';
import 'package:movie_helper/features/favorites/presentation/page/favorites.page.dart';

const kDiscoveryPage = '/discovery';
const kFavoritesPage = '/favorites';

final appRoutes = {
  kDiscoveryPage: (ctx) => const DiscoveryPage(),
  kFavoritesPage: (ctx) => const FavoritesPage(),
};
