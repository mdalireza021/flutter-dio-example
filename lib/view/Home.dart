import 'package:flutter/material.dart';
import '../controller/HomeController.dart';
import '../models/FeaturedProductResponse.dart';
import '../networking/ApiResponse.dart';
import '../widgets/ProductItem.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final HomeController _homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: const Text("DIO Example"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<ApiResponse<FeaturedProductResponse>>(
                  stream: _homeController.featuredProdStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status!) {
                        case Status.LOADING:
                          return CircularProgressIndicator();
                          break;
                        case Status.COMPLETED:
                          var data = snapshot.data?.data?.data ?? [];
                          return Column(
                            children: data
                                .map((e) => ProductItem(
                                name: e.name ?? "",
                                imageUrl: e.pictureModels?.first?.fullSizeImageUrl ?? "",
                                shortDescription: e.shortDescription ?? "",
                                fullDescription: e.fullDescription ?? "")

                            )
                                .toList(),
                          );
                          break;

                        case Status.ERROR:
                          return const Text("Error");
                          break;
                      }
                    }
                    return SizedBox.shrink();
                  }),

            ],
          ),
        )
    );
  }
}
