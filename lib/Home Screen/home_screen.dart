import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Component/custom_header.dart';
import '../Component/custom_image_banner.dart';
import '../Component/header2_delegates.dart';
import '../Component/second_header.dart';
import '../Component/text_container.dart';
import 'footer.dart';
import 'home_controller.dart';

class MenScreen extends StatefulWidget {
  const MenScreen({super.key});

  @override
  State<MenScreen> createState() => _MenScreenState();
}

class _MenScreenState extends State<MenScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyHomePageController()
        ..loadBannerImages()
        ..loadMenCategoryImages(),
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
                          images: controller.images,
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
                      ActionBanner(
                        title: "CATEGORIES FOR JEWELLERY",
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        containerColor: Colors.white,
                        textColor: Colors.black,
                        height: 53.0,
                        fontFamily: GoogleFonts.dancingScript()
                            .fontFamily, // A more elegant and welcoming font
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Consumer<MyHomePageController>(
                        builder: (context, controller, child) {
                          return controller.menCategoryImages.isNotEmpty
                              ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // Adjust number of columns based on screen width
                                int crossAxisCount = constraints.maxWidth > 600
                                    ? 5
                                    : (constraints.maxWidth > 300
                                    ? 3
                                    : (constraints.maxWidth > 200 ? 2 : 1));

                                // Dynamically adjust font size and image height based on screen width
                                double fontSize = constraints.maxWidth < 250
                                    ? 10.0
                                    : (constraints.maxWidth < 300 ? 12.0 : 16.0);
                                double imageHeight = constraints.maxWidth < 200
                                    ? 100
                                    : (constraints.maxWidth < 250
                                    ? 130
                                    : (constraints.maxWidth < 300 ? 150 : 200));

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 16.0,
                                    mainAxisSpacing: 16.0,
                                  ),
                                  itemCount: controller.menCategoryImages.length,
                                  itemBuilder: (context, index) {
                                    final item = controller.menCategoryImages[index];
                                    final itemTitle = item['item_title'] ?? '';

                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0),
                                        border: Border.all(color: Colors.white54, width: 1.5),
                                        gradient: LinearGradient(
                                          colors: [Colors.white, Colors.amber.shade100],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 8.0,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          // Image inside the container
                                          Expanded(
                                            child: MouseRegion(
                                              onEnter: (_) {
                                                setState(() {
                                                  controller.imageScales[index] = 1.5;
                                                });
                                              },
                                              onExit: (_) {
                                                setState(() {
                                                  controller.imageScales[index] = 1.0;
                                                });
                                              },
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Navigate to the selected item screen
                                                  context.go('/$itemTitle');
                                                },
                                                child: ClipRRect(
                                                  borderRadius: const BorderRadius.vertical(
                                                    top: Radius.circular(8.0),
                                                  ),
                                                  child: Transform.scale(
                                                    scale: controller.imageScales[index] ?? 1.0,
                                                    child: Image.network(
                                                      item['men_home_img'] ?? '',
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: imageHeight, // Dynamic image height
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Text below the image
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              itemTitle,
                                              style: TextStyle(
                                                fontSize: fontSize, // Adjusted font size
                                                fontFamily: GoogleFonts.dancingScript().fontFamily,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
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

                      const SizedBox(
                        height: 30,
                      ),

                      ActionBanner(
                        title: "🌟 Over 6 Million Happy Customers! 🌟",
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        containerColor: Colors.white,
                        textColor: Colors.black87,
                        height:
                            60.0, // Slightly increased height for better spacing
                        fontFamily: GoogleFonts.dancingScript()
                            .fontFamily, // A more elegant and welcoming font
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
