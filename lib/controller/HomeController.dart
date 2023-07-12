import 'dart:async';
import 'package:dio_example/networking/ApiResponse.dart';
import 'package:dio_example/repository/HomeRepository.dart';
import '../models/FeaturedProductResponse.dart';
import '../utils/Const.dart';

class HomeController {
   late  HomeRepository _homeRepository;
  StreamController? _featureProductStreamController;

  HomeController() {
    _homeRepository = HomeRepository();
    _featureProductStreamController = StreamController<ApiResponse<FeaturedProductResponse>>();
    getFeaturedProducts();
  }

  // Featured products sink
  StreamSink<ApiResponse<FeaturedProductResponse>> get featuredProdSink =>
      _featureProductStreamController!.sink
          as StreamSink<ApiResponse<FeaturedProductResponse>>;

  // Featured products stream
  Stream<ApiResponse<FeaturedProductResponse>> get featuredProdStream =>
      _featureProductStreamController?.stream
          as Stream<ApiResponse<FeaturedProductResponse>>;


  getFeaturedProducts() async {
    featuredProdSink.add(ApiResponse.loading(Const.COMMON_PLEASE_WAIT));

    try {
      var featuredProductResponse =
      await _homeRepository.fetchFeaturedProducts();
      featuredProdSink.add(ApiResponse.completed(featuredProductResponse));
    } catch (e) {
      featuredProdSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  clearFeaturedProducts() =>
      featuredProdSink.add(ApiResponse.completed(FeaturedProductResponse()));

  @override
  dispose() {
    _featureProductStreamController?.close();
  }
}
