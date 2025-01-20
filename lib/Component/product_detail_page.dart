import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping/Component/product_modal.dart';
import 'package:shopping/Component/second_header.dart';
import '../Component/custom_header.dart';
import '../Component/header2_delegates.dart';
import '../Home Screen/footer.dart';
import '../Home Screen/home_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product? product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Check if product is null
    if (widget.product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('')),
        body: const Center(
          child: Text('Product not found'),
        ),
      );
    }

    final images = widget.product!.itemImg.split(',');
    final Map<String, String> specifications =
    widget.product!.itemSize != null && widget.product!.itemSize.isNotEmpty
        ? Map<String, String>.from(jsonDecode(widget.product!.itemSize))
        : {};

    // Dynamic font size
    double getResponsiveFontSize(double baseSize) {
      if (screenWidth < 200) return baseSize * 0.7;
      if (screenWidth < 250) return baseSize * 0.8;
      if (screenWidth < 300) return baseSize * 0.9;
      return baseSize;
    }

    return ChangeNotifierProvider(
      create: (_) => MyHomePageController()
        ..loadBannerImages()
        ..loadMenCategoryImages(),
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
                    child: const Header2(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left: Images
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: List.generate(
                                      images.length,
                                          (index) => Padding(
                                        padding:
                                        const EdgeInsets.only(bottom: 8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                            ),
                                            child: Image.network(
                                              images[index],
                                              fit: BoxFit.cover,
                                              height: screenWidth * 0.4,
                                              width: screenWidth * 0.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Separator Line
                                Container(
                                  width: 1.0,
                                  color: Colors.grey.shade300,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                ),

                                // Right: Product Details
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Product Name
                                      Text(
                                        widget.product!.itemName,
                                        style: GoogleFonts.dancingScript(
                                          textStyle: TextStyle(
                                            fontSize: getResponsiveFontSize(28),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Product Price
                                      Text(
                                        '₹ ${widget.product!.itemPrice}',
                                        style: TextStyle(
                                          fontSize: getResponsiveFontSize(20),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Product Description
                                      Text(
                                        widget.product!.itemDesc,
                                        style: TextStyle(
                                          fontSize: getResponsiveFontSize(16),
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Product Specifications Table
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 4.0,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Table(
                                            border: TableBorder.all(
                                              color: Colors.grey.shade300,
                                              width: 1.0,
                                            ),
                                            columnWidths: const {
                                              0: FlexColumnWidth(1),
                                              1: FlexColumnWidth(2),
                                            },
                                            children: specifications.entries
                                                .map((entry) {
                                              return TableRow(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: Text(
                                                      entry.key,
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize:
                                                        getResponsiveFontSize(
                                                            16),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child: Text(
                                                      entry.value,
                                                      style: TextStyle(
                                                        fontSize:
                                                        getResponsiveFontSize(
                                                            16),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Add to Cart Button
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add logic to handle adding the product to the cart
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14, horizontal: 24),
                                          backgroundColor: Colors.yellowAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                            fontSize: getResponsiveFontSize(16),
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Footer
                const SliverToBoxAdapter(
                  child: ResponsiveFooter(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
