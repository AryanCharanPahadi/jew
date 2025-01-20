import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Component/product_modal.dart';

class ApiService {
  static const String _baseUrl = 'https://vedvika.com/jewellery/';

  static Future<List<Map<String, dynamic>>> fetchMenCategoryImages() async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/get_men_home_image.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // print('API Response: $data');  // Print the response to inspect

        // Extract the 'data' field containing the list of category items
        if (data['data'] != null) {
          return List<Map<String, dynamic>>.from(
            data['data'].map((item) => {
                  'men_home_img': item['men_home_img'] ?? '',
                  'item_title': item['item_title'] ?? '',
                }),
          );
        } else {
          throw Exception('No category images found');
        }
      } else {
        throw Exception('Failed to load images');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching category images: $e');
      }
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> fetchWomenCategoryImages() async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/get_women_home_image.php'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // print('API Response: $data');  // Print the response to inspect

        // Extract the 'data' field containing the list of category items
        if (data['data'] != null) {
          return List<Map<String, dynamic>>.from(
            data['data'].map((item) => {
                  'women_home_img': item['women_home_img'] ?? '',
                  'item_title': item['item_title'] ?? '',
                }),
          );
        } else {
          throw Exception('No women category images found');
        }
      } else {
        throw Exception('Failed to load women images');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching women category images: $e');
      }
      return [];
    }
  }

  Future<List<Product>> fetchWomenProducts(String itemTitle) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/get_women_item_details.php?item_title=$itemTitle'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data);
      List<Product> productList = [];
      for (var item in data['data']) {
        productList.add(Product.fromJson(item));
      }
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> fetchMenProducts(String itemTitle) async {
    final response = await http.get(
        Uri.parse('$_baseUrl/get_men_item_details.php?item_title=$itemTitle'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print(data);
      List<Product> productList = [];
      for (var item in data['data']) {
        productList.add(Product.fromJson(item));
      }
      return productList;
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch banner images
  static Future<List<String>> fetchMenBannerImages() async {
    const apiUrl = '$_baseUrl/get_men_wear_banner_img.php';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          final String bannerString = jsonResponse['data'][0]['men_banner'];
          final List<String> banners = bannerString.split(', ');
          return banners;
        } else {
          throw Exception('Error: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Failed to load banners. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching banners: $e');
    }
  }

  // Fetch banner images
  static Future<List<String>> fetchWomenBannerImages() async {
    const apiUrl = '$_baseUrl/get_women_wear_banner_img.php';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          final String bannerString = jsonResponse['data'][0]['women_banner'];
          final List<String> banners = bannerString.split(', ');
          return banners;
        } else {
          throw Exception('Error: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Failed to load banners. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching banners: $e');
    }
  }
}
