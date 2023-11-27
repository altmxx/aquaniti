import 'package:aquaniti/common/widgets.dart';
import 'package:aquaniti/features/home/services/home_services.dart';
import 'package:aquaniti/features/home/widgets/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    // homeProvider.getArticles();
    // if (homeProvider.article.isEmpty) {
    //   homeProvider.getArticles();
    // }
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
                  AppLocalizations.of(context)!.popularArticles,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              // ArticleWidget()
              // if (homeProvider.article.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 142.w / 200.h,
                  ),
                  itemBuilder: (ctx, i) {
                    // homeProvider.getArticles();
                    return ArticleWidget(article: homeProvider.article[i]);
                  },
                  itemCount: homeProvider.article.length,
                ),
              ),
              verticalSpace(24.h),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Row(
            children: [
              Text(
                "Marketplace",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 115, 209),
                ),
              ),
              Icon(
                Icons.shopping_bag_outlined,
                color: Color.fromARGB(255, 0, 115, 209),
              )
            ],
          )),
    );
  }
}
