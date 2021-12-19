import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCardWidget extends StatelessWidget {
String image;
String title;
String year;

MovieCardWidget({required this.image,required this.title,required this.year});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
      child: Container(
        height: 85.h,
        width: ScreenUtil().screenWidth/1.8.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),

        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 60.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: image,
                  errorWidget:(context, url, error) =>  Icon(Icons.error,color: Colors.black,size: 25.sp,),
                  progressIndicatorBuilder: (context, url, progress) => const Center(child: CircularProgressIndicator(),),
                ),
              ),
            ),
            ///title and year
            Expanded(
                flex: 5,
                child: Padding(
                  padding:  EdgeInsets.only(right: 100.w,top: 15.h),
                  child: Column(
                    children: [
                      ///title
                      Text(title,maxLines: 2,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14.sp),
                      ),
                      SizedBox(height: 5.h,),
                      ///year
                      Text(year,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 13.sp),),

                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
