import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Component/page_not_found.dart';
import 'Component/product_detail_page.dart';
import 'Component/product_grid.dart';
import 'Component/product_modal.dart';
import 'Component/wishlist_service.dart';
import 'Home Screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance(); // Ensure initialization
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define GoRouter
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MenScreen(),
        ),
        GoRoute(
          path: '/:itemTitle',
          builder: (context, state) {
            final itemTitle = state.pathParameters['itemTitle']!;
            return ProductGridMen(itemTitle: itemTitle);
          },
          routes: [
            // Nested route for product detail
            GoRoute(
              path: 'product-detail',
              builder: (context, state) {
                final product = state.extra as Product?; // Use nullable Product
                if (product == null) {
                  // Handle the case where the product is null
                  return const Scaffold(
                    body: Center(child: Text('')),
                  );
                }
                return ProductDetailScreen(
                  product: product,
                );
              },
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) =>
          PageNotFoundScreen(routeName: state.uri.toString()),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Dazzle',
      routerConfig: router,
    );
  }
}
