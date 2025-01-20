//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../Component/page_not_found.dart';
// import '../Component/product_grid.dart';
// import '../Component/women_product_grid.dart';
// import '../Home Screen/home_screen.dart';
// import '../Home Screen/women_screen.dart';
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Define GoRouter
//     final GoRouter router = GoRouter(
//       initialLocation: '/men',
//       routes: [
//         GoRoute(
//           path: '/men',
//           builder: (context, state) => const MenScreen(),
//         ),
//         GoRoute(
//           path: '/women',
//           builder: (context, state) => const WomenScreen(),
//         ),
//         // Add the dynamic route for item titles
//         GoRoute(
//           path: '/men/:itemTitle',
//           builder: (context, state) {
//             final itemTitle = state.pathParameters['itemTitle']!;
//             return ProductGridMen(
//                 itemTitle: itemTitle); // Show selected item screen
//           },
//         ),
//         GoRoute(
//           path: '/women/:itemTitle',
//           builder: (context, state) {
//             final itemTitle = state.pathParameters['itemTitle']!;
//             return ProductGridWomen(
//                 itemTitle: itemTitle); // Show selected item screen
//           },
//         ),
//       ],
//       errorBuilder: (context, state) => PageNotFoundScreen(
//           routeName: state.uri.toString()), // Handle invalid routes
//     );
//
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Printify',
//       routerConfig: router,
//     );
//   }
// }
