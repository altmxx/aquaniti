// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/constants/global_variables.dart';

import '../../../models/article.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  const ArticleWidget({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, left: 13.38.w, right: 13.38.w),
      // height: 200.h,
      width: 142.w,
      decoration: BoxDecoration(
        color: GlobalVariables.secondaryColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 115.25.w,
            height: 65.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Image.network(
              article.url,
              fit: BoxFit.cover,
            ),
          ),
          verticalSpace(4.h),
          Text(
            article.title,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(4.h),
          Text(
            article.summary,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(12.h),
          Row(
            children: [
              Text(
                "Tap for more details",
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
