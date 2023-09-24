import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/features/home/services/home_services.dart';
import 'package:aquaniti/features/home/widgets/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    // homeProvider.getArticles();

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(30.h),
            Container(
              width: 314.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            verticalSpace(26.h),
            Container(
              margin: EdgeInsets.only(left: 23.w),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                "Popular Articles",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // ArticleWidget()
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (ctx, i) {
                homeProvider.getArticles();
                return ArticleWidget(article: homeProvider.article[i]);
              },
              itemCount: homeProvider.article.length,
            )
          ],
        ),
      ),
    ));
  }
}
