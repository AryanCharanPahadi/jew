import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Component/custom_header.dart';
import '../Component/custom_image_banner.dart';
import '../Component/header2_delegates.dart';
import '../Component/second_header.dart';
import '../Component/text_container.dart';
import 'footer.dart';
import 'home_controller.dart';

class WomenScreen extends StatefulWidget {
  const WomenScreen({super.key});

  @override
  State<WomenScreen> createState() => _WomenScreenState();
}

class _WomenScreenState extends State<WomenScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyHomePageController()
        ..loadBannerImages()
        ..loadWomenCategoryImages(),
      child: Consumer<MyHomePageController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                // Custom Header (Non-sticky)
                const SliverToBoxAdapter(
                  child: Header(),
                ),

                // Sticky Header2
                SliverPersistentHeader(
                  pinned: true,
                  delegate: Header2Delegate(
                    child:  Header2(),
                  ),
                ),

                // Image Carousel
                SliverToBoxAdapter(
                  child: controller.images.isNotEmpty
                      ? ImageCarousel(
                          images: controller.images, // Pass the fetched images
                        )
                      : const Center(
                          child: Text('Loading images...'),
                        ),
                ),

                // Product Grid and other sections
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(
                        height: 30,
                      ),
                      const ActionBanner(
                        title: "CATEGORIES FOR WOMEN OUTLETS",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        containerColor: Colors.red,
                        textColor: Colors.white,
                        height: 53,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Consumer<MyHomePageController>(
                        builder: (context, controller, child) {
                          return controller.womenCategoryImages.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      int crossAxisCount =
                                          constraints.maxWidth > 600 ? 3 : 2;

                                      return GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: crossAxisCount,
                                          crossAxisSpacing: 20.0,
                                          mainAxisSpacing: 20.0,
                                        ),
                                        itemCount: controller
                                            .womenCategoryImages.length,
                                        itemBuilder: (context, index) {
                                          final item = controller
                                              .womenCategoryImages[index];
                                          final itemTitle =
                                              item['item_title'] ?? '';
                                          return MouseRegion(
                                            onEnter: (_) {
                                              setState(() {
                                                controller.imageScales[index] =
                                                    1.5;
                                              });
                                            },
                                            onExit: (_) {
                                              setState(() {
                                                controller.imageScales[index] =
                                                    1.0;
                                              });
                                            },
                                            cursor: SystemMouseCursors.click,
                                            child: GestureDetector(
                                              onTap: () {
                                                // Navigate to the selected item screen
                                                context.go('/women/$itemTitle');
                                              },
                                              child: Card(
                                                elevation: 4.0,
                                                child: Column(
                                                  children: [
                                                    itemTitle.isNotEmpty
                                                        ? Expanded(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child: Transform
                                                                  .scale(
                                                                scale: controller
                                                                            .imageScales[
                                                                        index] ??
                                                                    1.0,
                                                                child: Image
                                                                    .network(
                                                                  item['women_home_img'] ??
                                                                      '',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const Icon(Icons
                                                            .image_not_supported),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        itemTitle,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                );
                        },
                      ),
                      const ActionBanner(
                        title: "Purely Made In India",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        containerColor: Colors.red,
                        textColor: Colors.white,
                        height: 53,
                      ),
                      const ActionBanner(
                        title: "Over 6 Million Happy Customers",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        containerColor: Colors.white,
                        textColor: Colors.black,
                        height: 53,
                      ),
                      const ResponsiveFooter(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
