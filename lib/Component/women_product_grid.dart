// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shopping/Api%20Helper/api_helper.dart';
// import 'package:shopping/Component/product_modal.dart';
// import 'package:shopping/Component/value_listenable_builder2.dart';
// import '../Component/custom_header.dart';
// import '../Component/custom_image_banner.dart';
// import '../Component/header2_delegates.dart';
// import '../Component/second_header.dart';
// import '../Component/text_container.dart';
// import '../Home Screen/footer.dart';
// import '../Home Screen/home_controller.dart';
//
// class ProductGridWomen extends StatefulWidget {
//   final String itemTitle;
//
//   const ProductGridWomen({
//     super.key,
//     required this.itemTitle,
//   });
//
//   @override
//   State<ProductGridWomen> createState() => _ProductGridWomenState();
// }
//
// class _ProductGridWomenState extends State<ProductGridWomen> {
//   late Future<List<Product>> _products;
//
//   @override
//   void initState() {
//     super.initState();
//     _products = ApiService().fetchWomenProducts(widget.itemTitle);
//   }
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
//                     child: const Header2(),
//                   ),
//                 ),
//
//                 // Image Carousel
//                 SliverToBoxAdapter(
//                   child: controller.images.isNotEmpty
//                       ? ImageCarousel(
//                           images: controller.images,
//                         )
//                       : const Center(
//                           child: Text('Loading images...'),
//                         ),
//                 ),
//
//                 SliverList(
//                   delegate: SliverChildListDelegate(
//                     [
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       ActionBanner(
//                         title: "Looking for ${widget.itemTitle}",
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         containerColor: Colors.red,
//                         textColor: Colors.white,
//                         height: 53,
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       FutureBuilder<List<Product>>(
//                         future: _products,
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           } else if (snapshot.hasError) {
//                             return const Center(
//                                 child: Text('No Products Found'));
//                           } else if (!snapshot.hasData ||
//                               snapshot.data!.isEmpty) {
//                             return const Center(
//                                 child: Text('No Products Found'));
//                           } else {
//                             var products = snapshot.data!;
//                             return LayoutBuilder(
//                               builder: (context, constraints) {
//                                 int crossAxisCount =
//                                     2; // Default to 2 columns for small screens
//
//                                 if (constraints.maxWidth > 600) {
//                                   crossAxisCount =
//                                       4; // Show 4 columns for larger screens
//                                 }
//
//                                 return GridView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: crossAxisCount,
//                                     crossAxisSpacing: 20,
//                                     mainAxisSpacing: 20,
//                                     childAspectRatio: 0.80,
//                                   ),
//                                   itemCount: products.length,
//                                   itemBuilder: (context, index) {
//                                     // Split the image URLs
//                                     List<String> images =
//                                         products[index].itemImg.split(',');
//
//                                     // ValueNotifier for hover index or zoom
//                                     ValueNotifier<int> hoveredImageIndex =
//                                         ValueNotifier<int>(0);
//                                     ValueNotifier<bool> isZoomed =
//                                         ValueNotifier<bool>(false);
//
//                                     return Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0, vertical: 10.0),
//                                       child: MouseRegion(
//                                         onEnter: (_) {
//                                           if (images.length > 1) {
//                                             hoveredImageIndex.value =
//                                                 1; // Show the second image on hover
//                                           } else {
//                                             isZoomed.value =
//                                                 true; // Zoom the image if there's only one
//                                           }
//                                         },
//                                         onExit: (_) {
//                                           hoveredImageIndex.value =
//                                               0; // Reset to the first image
//                                           isZoomed.value =
//                                               false; // Stop zooming for single image
//                                         },
//                                         child:
//                                             ValueListenableBuilder2<int, bool>(
//                                           first: hoveredImageIndex,
//                                           second: isZoomed,
//                                           builder: (context, hoveredIndex,
//                                               zoomed, child) {
//                                             return Container(
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                   color: Colors
//                                                       .redAccent, // Set border color
//                                                   width:
//                                                       1.5, // Set border width
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         8.0), // Rounded corners
//                                               ),
//                                               padding: const EdgeInsets.all(
//                                                   8.0), // Space inside the border
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Expanded(
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               5),
//                                                       child: Stack(
//                                                         children: [
//                                                           AnimatedScale(
//                                                             scale: zoomed
//                                                                 ? 1.5
//                                                                 : 1.0, // Slightly zoom in the image
//                                                             duration:
//                                                                 const Duration(
//                                                                     milliseconds:
//                                                                         300),
//                                                             child:
//                                                                 Image.network(
//                                                               images[
//                                                                   hoveredIndex],
//                                                               fit: BoxFit.cover,
//                                                               width: double
//                                                                   .infinity,
//                                                               height: double
//                                                                   .infinity,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding: const EdgeInsets
//                                                         .symmetric(
//                                                         vertical: 8.0),
//                                                     child: Text(
//                                                       products[index].itemName,
//                                                       maxLines: 1,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style: const TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 16,
//                                                         color: Colors.black87,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     '₹ ${products[index].itemPrice}',
//                                                     style: const TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 14,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           }
//                         },
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       const ActionBanner(
//                         title: "Purely Made In India",
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         containerColor: Colors.red,
//                         textColor: Colors.white,
//                         height: 53,
//                       ),
//                       const ActionBanner(
//                         title: "Over 6 Million Happy Customers",
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         containerColor: Colors.white,
//                         textColor: Colors.black,
//                         height: 53,
//                       ),
//                       const ResponsiveFooter(),
//                     ],
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
