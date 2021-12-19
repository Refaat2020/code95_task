import 'package:code95_task/constant/k_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QueryButtonWidget extends StatelessWidget {
Function onTap;

QueryButtonWidget(this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
       onTap();
      } ,
      child: Container(
        height: 50.h,
        width: ScreenUtil().screenWidth/1.1,
        decoration: BoxDecoration(
            color:kSearchBlue ,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: kSearchBlue,width:1.5 )
        ),
        child: Center(
          child: Icon(Icons.search,size: 30.sp,color: Colors.white,),
        ),
      ),
    );
  }
}
