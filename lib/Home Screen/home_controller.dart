import 'package:flutter/foundation.dart';
import '../Api Helper/api_helper.dart';

class MyHomePageController extends ChangeNotifier {
  List<String> _images = []; // List of images (initially empty)

  List<String> get images => _images;
  Map<int, double> imageScales = {};

  // Load Banner Images for Men
  Future<void> loadBannerImages() async {
    try {
      List<String> banners = await ApiService.fetchMenBannerImages();
      _images = banners;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading banners: $e');
      }
    }
  }

  // Load Banner Images for Women
  Future<void> loadBannerImagesWomen() async {
    try {
      List<String> banners = await ApiService.fetchWomenBannerImages();
      _images = banners;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading banners: $e');
      }
    }
  }

  List<Map<String, dynamic>> _menCategoryImages = [];

  List<Map<String, dynamic>> get menCategoryImages => _menCategoryImages;

  List<Map<String, dynamic>> _womenCategoryImages = [];

  List<Map<String, dynamic>> get womenCategoryImages => _womenCategoryImages;

  // Load Category Images for Men
  Future<void> loadMenCategoryImages() async {
    try {
      List<Map<String, dynamic>> images =
          await ApiService.fetchMenCategoryImages();
      _menCategoryImages = images;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading category images: $e');
      }
    }
  }

  // Load Category Images for women
  Future<void> loadWomenCategoryImages() async {
    try {
      List<Map<String, dynamic>> images =
          await ApiService.fetchWomenCategoryImages();
      _womenCategoryImages = images;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error loading category images: $e');
      }
    }
  }
}
