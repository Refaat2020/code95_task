import 'package:code95_task/constant/k_colors.dart';
import 'package:code95_task/cubit/query_cubit.dart';
import 'package:code95_task/ui/widgets/query_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> firstCondition = ["Title","Year",];
  List<String>andOr = ["AND","OR"];
  List<String>operator = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<QueryCubit>().getTopMovies();
    context.read<QueryCubit>().condition1 = "Title";
    context.read<QueryCubit>().operator1 = "Start with";
    context.read<QueryCubit>().andOr = "AND";
  }
  @override
  Widget build(BuildContext context) {
   final queryCubit = context.watch<QueryCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ///Header
          Padding(
            padding:  EdgeInsets.only(top: 50.h,left: 20.w),
            child: Row(
              children: [
                Text("Query Builder",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black,fontSize: 32.sp,),),
                const Spacer(),
                IconButton(onPressed: (){
                  queryCubit.addMore = true;
                  setState(() {

                  });
                }, icon: Icon(Icons.add_circle_outline,color: Colors.green,size:  queryCubit.addMore == false ?35.sp:0)),
                SizedBox(width: 10.w,),
              ],
            ),
          ),
          SizedBox(height: 30.h,),
          /// form
          Padding(
            padding:  EdgeInsets.only(left: 15.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120.h,

                  width: ScreenUtil().screenWidth/1.1,
                  decoration: BoxDecoration(
                    color: kLiteGrey,
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: 12.h,left: 15.w,bottom: 15.h),
                        child: Row(
                          children: [
                            Container(
                              child: FormBuilderDropdown<String>(
                                name: "firstCondition",

                                icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 22.sp,),
                                items: queryCubit.firstCondition.map((condition) {
                                  return  DropdownMenuItem<String>(
                                    value: condition,
                                    child:  Text(
                                      condition,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }).toList(),
                                hint: Text("Title",style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),),
                                allowClear: false,

                                onChanged: (value) {
                                  queryCubit.changeOp1(value);
                                } ,
                                decoration:  InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15.w),
                                  hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,

                                  ),

                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                      borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                      borderSide:const BorderSide(color:  Color(0xffd6d2d2),width: 1.5)
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                      borderSide:const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                      borderSide:const BorderSide(color: Colors.red,width: 1.5),
                                  ),
                                ),
                              ),
                              width: ScreenUtil().screenWidth/1.8,
                              decoration:BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                              ) ,

                            ),
                            const Spacer(),
                            Container(
                              child: DropdownButtonFormField<String>(
                                elevation: 0,
                                key: UniqueKey(),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                iconSize: 20.sp,
                                hint: Text("Start",style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),),
                                  onChanged: (value) {
                                      queryCubit.operator1 = value!;
                                    } ,
                                items: queryCubit.operatorList1.map(( operator) {
                                  return  DropdownMenuItem<String>(
                                    value: operator,
                                    child:  Text(
                                      operator,
                                      style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:14.sp,
                                                  fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }).toList(),
                                decoration:  InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15.w),
                              hintStyle: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,

                              ),

                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                  borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                  borderSide:const BorderSide(color:  Color(0xffd6d2d2),width: 1.5)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                  borderSide:const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                              ),
                            ),

                              ),
                              width: ScreenUtil().screenWidth/3.7,
                              height: 35.h,
                              decoration:BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                              ) ,
                            ),
                            SizedBox(width: 10.w,),
                          ],
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.only(left: 15.w,),
                        child: Container(
                          width: ScreenUtil().screenWidth/1.2,
                          decoration:BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6.r)),
                          ) ,

                          child: FormBuilderTextField(
                            name: "name",
                            controller:queryCubit.firstConditionController,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                            ),

                            validator:(value) {
                              // if (value == null || value == "") {
                              //   return "Please add the value";
                              // }
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: queryCubit.condition1 == "Title"?TextInputType.text:TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 15.w),
                              hintText: "John Doe",
                              hintStyle: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,

                              ),

                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                  borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                  borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                  borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                              ),
                            ),
                            onSaved: (newValue) {
                              queryCubit.firstConditionValue = newValue!;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                Container(

                  child: FormBuilderDropdown<String>(
                    name: "And/Or",

                    icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 22.sp,),
                    items: andOr.map((condition) {
                      return  DropdownMenuItem<String>(
                        value: condition,
                        child:  Text(
                          condition,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    hint: Text("AND",style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),),
                    allowClear: false,
                    validator: (value) {
                      // if (value == null || value == "") {
                      //   return "Please Select Plug";
                      // }
                    },
                    onChanged: (value) {
                      queryCubit.andOr=value!;
                      // plug2 = value!.id;
                      // print(plug2);
                    } ,
                    decoration:  InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.w),
                      hintStyle: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,

                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.r)),
                          borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.r)),
                          borderSide:const BorderSide(color:  Color(0xffd6d2d2),width: 1.5)
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.r)),
                          borderSide:const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                      ),
                    ),
                  ),
                  width: ScreenUtil().screenWidth/4,
                  // padding: EdgeInsets.only(top: 20.h,left: 15.w),
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  ) ,

                ),
                SizedBox(height: 24.h,),
                queryCubit.addMore== true?
                Container(
                  height: 115.h,

                  width: ScreenUtil().screenWidth/1.1,
                  decoration: BoxDecoration(
                    color: kLiteGrey,
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 12.h,left: 15.w,bottom: 15.h),
                            child: Row(
                              children: [
                                Container(

                                  child: FormBuilderDropdown<String>(
                                    name: "SecondCondition",

                                    icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 22.sp,),
                                    items: firstCondition.map((condition) {
                                      return  DropdownMenuItem<String>(
                                        value: condition,
                                        child:  Text(
                                          condition,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text("Title",style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),),
                                    allowClear: false,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return "Please Select Condition";
                                      }
                                    },
                                    onChanged: (value) {
                                      queryCubit.changeOp2(value);
                                    } ,
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15.w),
                                      hintStyle: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,

                                      ),

                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                          borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                          borderSide:const BorderSide(color:  Color(0xffd6d2d2),width: 1.5)
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                          borderSide:const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                      ),
                                    ),
                                  ),
                                  width: ScreenUtil().screenWidth/2.1,
                                  // padding: EdgeInsets.only(top: 20.h,left: 15.w),
                                  decoration:BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                  ) ,

                                ),
                                SizedBox(width: 10.w,),

                                Container(

                                  child: BlocBuilder<QueryCubit, QueryState>(
                                  builder: (context, state) {
                                    if (state is ChangeCondition) {
                                      return FormBuilderDropdown<String>(
                                        name: "secondOperatorCondition",
                                        key: UniqueKey(),
                                        icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 22.sp,),
                                        items: queryCubit.operatorList2.map((condition) {
                                          return  DropdownMenuItem<String>(
                                            value: condition,
                                            child:  Text(
                                              condition,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:14.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text("=",style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),),
                                        allowClear: false,
                                        validator: (value) {
                                          if (value == null || value == "") {
                                            return "Please Select Operator";
                                          }
                                        },
                                        onChanged: (value) {
                                          queryCubit.operator2 = value!;
                                          // plug2 = value!.id;
                                          // print(plug2);
                                        } ,
                                        decoration:  InputDecoration(
                                          contentPadding: EdgeInsets.only(left: 15.w),
                                          hintStyle: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54,

                                          ),

                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                              borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                              borderSide:const BorderSide(color:  Color(0xffd6d2d2),width: 1.5)
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                              borderSide:const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                          ),
                                        ),
                                      );
                                    }
                                    return FormBuilderDropdown<String>(
                                    name: "secondOperatorCondition",

                                    icon: Icon(Icons.arrow_drop_down,color: Colors.black,size: 22.sp,),
                                    items: operator.map((condition) {
                                      return  DropdownMenuItem<String>(
                                        value: condition,
                                        child:  Text(
                                          condition,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    }).toList(),
                                    hint: Text("=",style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),),
                                    allowClear: false,
                                    validator: (value) {
                                  if (value == null || value == "") {
                                      return "Please Select Operator";
                                    }
                                    },
                                    onChanged: (value) {
                                      queryCubit.operator2 = value!;
                                      // plug2 = value!.id;
                                      // print(plug2);
                                    } ,
                                    decoration:  InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 15.w),
                                      hintStyle: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,

                                      ),

                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                          borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                          borderSide:const BorderSide(color:  Color(0xffd6d2d2),width: 1.5)
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                          borderSide:const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                      ),
                                    ),
                                  );
                                    },
                                  ),
                                  width: ScreenUtil().screenWidth/4.8,
                                  // padding: EdgeInsets.only(top: 20.h,left: 15.w),
                                  decoration:BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                                  ) ,

                                ),
                                SizedBox(width: 10.w,),

                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: 15.w,),
                            child: Container(
                              width: ScreenUtil().screenWidth/1.4,
                              decoration:BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(6.r)),
                              ) ,

                              child: FormBuilderTextField(
                                name: "second",
                                controller:queryCubit.secondConditionController,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),

                                validator:(value) {
                                  if (value == null || value == "") {
                                    return "Please add the value";
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 15.w),
                                  hintText: "John Doe",
                                  hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,

                                  ),

                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                      borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                      borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                                      borderSide: const BorderSide(color: Color(0xffd6d2d2),width: 1.5)
                                  ),
                                ),
                                onSaved: (newValue) {
                                  // plateNumber = newValue!;
                                  queryCubit.secondConditionValue = newValue!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 40.h,right: 10.w),
                            child: IconButton(icon:Icon( Icons.highlight_remove_outlined,color: kRemoveRed,size: 35.sp,),onPressed: (){
                              queryCubit.addMore = false;
                              queryCubit.condition2 = "";
                              setState(() {

                              });
                            },),
                          ),

                        ],
                      ),

                    ],
                  ),
                )
                :SizedBox(height: 10.h,),
                SizedBox(height: 24.h,),
                QueryButtonWidget((){
                  if (queryCubit.firstConditionController.text=="") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please add the value for query",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w700,color: Colors.white),),elevation: 5,backgroundColor: Colors.black,duration: const Duration(seconds: 3),));
                    return;

                  }
                  if (queryCubit.condition1 == queryCubit.condition2) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You cannot perform query with same conditions",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w700,color: Colors.white),),elevation: 5,backgroundColor: Colors.black,duration: const Duration(seconds: 3),));
                    return;
                  }
                  queryCubit.checkConditions(context);

                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
