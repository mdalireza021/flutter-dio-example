import 'package:dio_example/networking/ApiBaseHelper.dart';
import 'package:dio_example/networking/Endpoints.dart';
import '../models/FeaturedProductResponse.dart';

class HomeRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<FeaturedProductResponse> fetchFeaturedProducts() async {
    final response = await _helper.get(Endpoints.featuredProduct);
    return FeaturedProductResponse.fromJson(response);
  }
}
