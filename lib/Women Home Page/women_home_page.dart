// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../Component/custom_header.dart';
// import '../Component/custom_image_banner.dart';
// import '../Component/header2_delegates.dart';
// import '../Component/second_header.dart';
// import '../Home Screen/home_controller.dart';
//
// class WomenHomePage extends StatelessWidget {
//   const WomenHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => MyHomePageController()..loadBannerImages(),
//       child: Consumer<MyHomePageController>(
//         builder: (context, controller, child) {
//           return Scaffold(
//             body: CustomScrollView(
//               slivers: [
//                 // Custom Header (Non-sticky)
//                 const SliverToBoxAdapter(
//                   child: Header(),
//                 ),
//
//                 // Sticky Header2
//                 SliverPersistentHeader(
//                   pinned: true,
//                   delegate: Header2Delegate(
//                     child: Header2(
//                       selectedMenuItem: controller.selectedMenuItem,
//                       onMenuItemSelected: (selectedItem) {
//                         controller.selectMenuItem(selectedItem);
//                       },
//                     ),
//                   ),
//                 ),
//
//                 // Image Carousel
//                 SliverToBoxAdapter(
//                   child: controller.images.isNotEmpty
//                       ? ImageCarousel(
//                     images: controller.images, // Pass the fetched images
//                   )
//                       : const Center(
//                     child: Text('Loading images...'),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
