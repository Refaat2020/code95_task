import 'package:code95_task/constant/k_colors.dart';
import 'package:code95_task/cubit/query_cubit.dart';
import 'package:code95_task/ui/widgets/movie_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QueryResultScreen extends StatefulWidget {

  @override
  _QueryResultScreenState createState() => _QueryResultScreenState();
}

class _QueryResultScreenState extends State<QueryResultScreen> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLiteGrey,
      body: ListView(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 40.h,left: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back,color: Colors.black,size: 30.sp,)),
                SizedBox(height: 25.h,),
                Text("Movies",style: TextStyle(color: Colors.black,fontSize: 35.sp),),
                SizedBox(height: 22.h,),
                ///build based on state of query
                BlocBuilder<QueryCubit, QueryState>(
                builder: (context, state) {
                  if (state is QueryLoading) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  else if(state is QueryAfterFilter){
                    return ListView.separated(
                      itemCount: state.moviesList.length,
                      shrinkWrap: true,
                      controller: _scrollController,
                      separatorBuilder: (context, index) => SizedBox(height: 15.h,),
                      padding: EdgeInsets.only(right: 10.w),
                      itemBuilder: (context, index) {
                        return MovieCardWidget(title: state.moviesList[index].title,image: state.moviesList[index].image,year: state.moviesList[index].year,);
                      },

                    );
                  }
                  else if(state is QueryEmpty){
                    return Padding(
                      padding: EdgeInsets.only(top: 50.h,left: 10.w),
                      child: Text("There are no movies with these conditions",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w800,color: kSearchBlue),),);
                  }
                  return Container();
                },
              ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
