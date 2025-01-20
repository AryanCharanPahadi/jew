import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping/Api%20Helper/api_helper.dart';
import 'package:shopping/Component/product_detail_page.dart';
import 'package:shopping/Component/product_modal.dart';
import 'package:shopping/Component/wishlist_controller.dart';
import '../Component/custom_header.dart';
import '../Component/custom_image_banner.dart';
import '../Component/header2_delegates.dart';
import '../Component/second_header.dart';
import '../Component/text_container.dart';
import '../Home Screen/footer.dart';
import '../Home Screen/home_controller.dart';

class ProductGridMen extends StatefulWidget {
  final String itemTitle;

  const ProductGridMen({
    super.key,
    required this.itemTitle,
  });

  @override
  State<ProductGridMen> createState() => _ProductGridMenState();
}

class _ProductGridMenState extends State<ProductGridMen> {
  late Future<List<Product>> _products;

  ValueNotifier<bool> isLiked = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
    _products = ApiService().fetchMenProducts(widget.itemTitle);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => MyHomePageController()..loadBannerImages(),
        child: Consumer<MyHomePageController>(
        builder: (context, controller, child) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Header(),
            ),

            SliverPersistentHeader(
              pinned: true,
              delegate: Header2Delegate(
                child: Header2(),
              ),
            ),

            SliverToBoxAdapter(
              child: controller.images.isNotEmpty
                  ? ImageCarousel(
                images: controller.images,
              )
                  : const Center(
                child: Text('Loading images...'),
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    height: 30,
                  ),
                  ActionBanner(
                    title: "Looking for ${widget.itemTitle}",
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    containerColor: Colors.white,
                    textColor: Colors.black,
                    height: 53.0,
                    fontFamily: GoogleFonts.dancingScript().fontFamily,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder<List<Product>>(
                    future: _products,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No Products Found'));
                      } else {
                        var products = snapshot.data!;
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            double screenWidth = constraints.maxWidth;

                            int crossAxisCount;
                            if (screenWidth <= 200) {
                              crossAxisCount = 1;
                            } else if (screenWidth <= 250) {
                              crossAxisCount = 2;
                            } else if (screenWidth <= 300) {
                              crossAxisCount = 2;
                            } else if (screenWidth > 600) {
                              crossAxisCount = 4;
                            } else {
                              crossAxisCount = 3;
                            }

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: screenWidth <= 250 ? 0.6 : 0.8,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                List<String> images = products[index].itemImg.split(',');
                                ValueNotifier<int> hoveredImageIndex = ValueNotifier<int>(0);
                                ValueNotifier<bool> isZoomed = ValueNotifier<bool>(false);
                                ValueNotifier<bool> isLiked = ValueNotifier<bool>(false);

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      context.go(
                                        '/${products[index].itemTitle}/product-detail',
                                        extra: products[index],
                                      );
                                    },
                                    child: MouseRegion(
                                      onEnter: (_) {
                                        if (images.length > 1) {
                                          hoveredImageIndex.value = 1;
                                        } else {
                                          isZoomed.value = true;
                                        }
                                      },
                                      onExit: (_) {
                                        hoveredImageIndex.value = 0;
                                        isZoomed.value = false;
                                      },
                                      child: ValueListenableBuilder2<int, bool>(
                                        first: hoveredImageIndex,
                                        second: isZoomed,
                                        builder: (context, hoveredIndex, zoomed, child) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1.5,
                                              ),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(5),
                                                        child: AnimatedScale(
                                                          scale: zoomed ? 1.5 : 1.0,
                                                          duration: const Duration(milliseconds: 300),
                                                          child: Image.network(
                                                            images[hoveredIndex],
                                                            fit: BoxFit.cover,
                                                            width: double.infinity,
                                                            height: double.infinity,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 8,
                                                        right: 8,
                                                        child: ValueListenableBuilder<bool>(
                                                          valueListenable: isLiked,
                                                          builder: (context, liked, child) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                isLiked.value = !liked;
                                                              },
                                                              child: Icon(
                                                                liked ? Icons.favorite : Icons.favorite_border,
                                                                color: liked ? Colors.red : Colors.grey,
                                                                size: 24,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                                  child: Text(
                                                    products[index].itemName,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: GoogleFonts.dancingScript().fontFamily,
                                                      fontSize: screenWidth <= 250 ? 12 : 16,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '₹ ${products[index].itemPrice}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: screenWidth <= 250 ? 10 : 14,
                                                    fontFamily: GoogleFonts.dancingScript().fontFamily,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
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
                    textColor: Colors.black,
                    height: 53.0,
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

/// A generic builder widget that listens to two `ValueNotifier`s and rebuilds
/// its widget tree when either of the notifiers changes.
class ValueListenableBuilder2<A, B> extends StatelessWidget {
  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget Function(BuildContext context, A firstValue, B secondValue, Widget? child) builder;
  final Widget? child;

  const ValueListenableBuilder2({
    Key? key,
    required this.first,
    required this.second,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (context, firstValue, child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, secondValue, child) {
            return builder(context, firstValue, secondValue, this.child);
          },
        );
      },
    );
  }
}



