import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/features/marketplace/widgets/marketplace_carousel.dart';
import 'package:aquaniti/features/marketplace/widgets/marketplace_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../services/marketplace_service.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({super.key});

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final marketplaceProvider =
        Provider.of<MarketplaceProvider>(context, listen: false);
    marketplaceProvider.fetchAndSetMarketplaceProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final marketplaceProvider = Provider.of<MarketplaceProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(22.h),
              // Container(
              //   width: 316.w,
              //   height: 180.h,
              //   color: Colors.grey,
              // ),
              MarketplaceCarousel(),
              verticalSpace(27.h),
              marketplaceProvider.marketPlaceItems.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.52,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (ctx, i) {
                        return MarketPlaceWidget(
                          marketPlaceItem:
                              marketplaceProvider.marketPlaceItems[i],
                        );
                      },
                      itemCount: marketplaceProvider.marketPlaceItems.length,
                    ),
              verticalSpace(22.h),
            ],
          ),
        ),
      )),
    );
  }
}
