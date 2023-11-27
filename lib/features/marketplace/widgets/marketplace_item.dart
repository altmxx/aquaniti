// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aquaniti/common/widgets.dart';
// import 'package:aquaniti/features/marketplace/screens/marketplace_screen.dart';
import 'package:aquaniti/models/marketplace_item.dart';

class MarketPlaceWidget extends StatelessWidget {
  final MarketPlaceItem marketPlaceItem;
  const MarketPlaceWidget({
    Key? key,
    required this.marketPlaceItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.w,
      // height: 201.h,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0XFFDAF0FF),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 90.h,
            // width: 134.w,
            decoration: BoxDecoration(
              // color: Colors.grey,
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                  image: NetworkImage(marketPlaceItem.image),
                  fit: BoxFit.fitWidth),
            ),
          ),
          verticalSpace(4.h),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    marketPlaceItem.name,
                    style: TextStyle(
                      height: 0,
                      fontSize: 14.sp,
                    ),
                  ),
                  horizontalSpace(6.w),
                  Text(
                    marketPlaceItem.bName,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              // horizontalSpace(37.w),
              Text(
                "₹${marketPlaceItem.price}",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          verticalSpace(5.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Water FootPrint: ${marketPlaceItem.waterFootprint}L/kg",
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          verticalSpace(4.h),
          Text(
            marketPlaceItem.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
            ),
          ),
          verticalSpace(12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xff4C88B1),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add to cart",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
