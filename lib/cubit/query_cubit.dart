import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:code95_task/constant/k_urls.dart';
import 'package:code95_task/model/movie_model.dart';
import 'package:code95_task/ui/screens/query_result_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'query_state.dart';

class QueryCubit extends Cubit<QueryState> {
  QueryCubit() : super(QueryInitial());

  List<MovieItems>moviesList = [];
  List<String> firstCondition = ["Title","Year",];
  List<String>andOrList = ["AND","OR"];
  List<String>operatorList1 = [];
  List<String>operatorList2 = [];
  TextEditingController firstConditionController = TextEditingController();
  TextEditingController secondConditionController = TextEditingController();

  List<String>stringOp = ["Start with","End with","Contains","exact"];
  String operator1 = "";
  String condition1 = "";
  String condition2 = "";
  String firstConditionValue="";
  String secondConditionValue="";
  bool addMore = false;
  List titleOp = ["Start with"];
  List<String>yearOp = ["="];
  String operator2 = "";
  String andOr = "";
  List<MovieItems>queryMovies = [];

  ///change op1
  changeOp1(value){
    emit(QueryLoading());
    condition1 = value!;

    if (addMore == true) {
      print(condition1);

      if (value == "Title") {
        operatorList1 = ["Start with"];
      }else{
        operatorList1 = ["="];
      }

    } else {
      if (value == "Title") {
        operatorList1 = ["Start with","End with","Contains","exact"];
      }else{
        operatorList1 = ["=", "!=", ">", "<"];
      }
    }
    emit( ChangeCondition());

  }
///change op2
changeOp2(value){
    emit(QueryLoading());
  condition2 = value!;
  print(condition2);
  if (value == "Title") {
    operatorList2 = ["Start with"];
  }else{
    operatorList2 = ["=",];
  }
  emit( ChangeCondition());
}
///get top 250 movies
  Future<MovieModel>getTopMovies()async{
    emit(QueryLoading());
    MovieModel? movies;
    http.Response response;
    response = await http.get(
      Uri.parse(kMoviesUrl),
      headers: {},
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      movies = MovieModel.fromJson(responseJson);
      moviesList=movies.items;
      print(moviesList.length);
      emit(QueryFetched(moviesList: moviesList));
    }else{
      emit(QueryError());
    }


    return movies!;
  }

  /// check Conditions
void checkConditions(BuildContext context){
    if (condition1 != ""&& condition2 !="") {

      if (andOr == "AND") {
        twoConditionsWithAnd(context,);
      }else{
        twoConditionsWithOr(context,firstConditionValue,secondConditionValue);

      }
      return;
    }else if (condition1 != ""){
      switch(condition1) {
        case "Title": {
          filterListByTitle(context,firstConditionController.text,operator1);
        }
        break;

        case "Year": {
         filterListByYear(context,firstConditionController.text,operator1);
        }
        break;
        default: {
          //statements;
        }
        break;
      }
    }
}
/// Query by year
Future<List<MovieItems>> filterListByYear(BuildContext context,String year,String operator)async{
    emit(QueryLoading());
    print("$year");
    switch(operator) {
      case "=": {
        for (var element in moviesList) {
          if (int.parse(element.year) == int.parse(year)) {
            queryMovies.add(element);
          }
        }
      }
      break;

      case ">": {
        for (var element in moviesList) {
          if (int.parse(element.year) > int.parse(year)) {
            queryMovies.add(element);
          }
        }
      }
      break;
      case "<":{
        for (var element in moviesList) {
          if (int.parse(element.year) < int.parse(year)) {
            queryMovies.add(element);
          }
        }
      }

      break;
      case "!=":{
        for (var element in moviesList) {
          if (int.parse(element.year) != int.parse(year)) {
            queryMovies.add(element);
          }
        }

      }

      break;
      default: {
        //statements;
      }
      break;
    }

    if (queryMovies.isEmpty) {
      emit(const QueryEmpty());

    }else{
      emit(QueryAfterFilter(moviesList: queryMovies));
    }

    queryMovies = [];
    Navigator.push(context, MaterialPageRoute(builder: (context) => QueryResultScreen(),));
    print(queryMovies.length);

    return queryMovies;
}
///query by text
Future<List<MovieItems>> filterListByTitle(BuildContext context,String title,String operator)async{
    emit(QueryLoading());
    print("operator");
    switch(operator) {
      case "Start with": {
        for (var element in moviesList) {
          if (element.title.startsWith(title.toUpperCase())) {
            queryMovies.add(element);
          }
        }
      }
      break;

      case "End with": {
        for (var element in moviesList) {
          if (element.title.endsWith(title.toLowerCase())) {
            queryMovies.add(element);
          }
        }
      }
      break;
      case "Contains":{
        for (var element in moviesList) {
          if (element.title.contains(title)) {
            queryMovies.add(element);
          }
        }
      }

      break;
      case "exact":{
        for (var element in moviesList) {
          if (element.title  == title) {
            queryMovies.add(element);
          }
        }

      }

      break;
      default: {
        //statements;
      }
      break;
    }

    if (queryMovies.isEmpty) {
      emit(const QueryEmpty());

    }else{
      emit(QueryAfterFilter(moviesList: queryMovies));
    }

    queryMovies = [];
    Navigator.push(context, MaterialPageRoute(builder: (context) => QueryResultScreen(),));
    print(queryMovies.length);
    return queryMovies;
  }

  /// query for two conditions with &&
  void twoConditionsWithAnd(BuildContext context,){
    emit(QueryLoading());
    String year = condition1 == "Year"?firstConditionController.text:secondConditionController.text;
    String title = condition2 == "Title"?secondConditionController.text:firstConditionController.text;
    for (var element in moviesList) {
      if (int.parse(element.year) == int.parse(year) && element.title.startsWith(title.toUpperCase()) ) {
        queryMovies.add(element);
      }
    }
    if (queryMovies.isEmpty) {
      emit( QueryEmpty());
      Navigator.push(context, MaterialPageRoute(builder: (context) => QueryResultScreen(),));

      return;

    }
    emit(QueryAfterFilter(moviesList: queryMovies));
    Navigator.push(context, MaterialPageRoute(builder: (context) => QueryResultScreen(),));

    queryMovies = [];

  }

  /// query for two conditions with ||

  void twoConditionsWithOr(BuildContext context,String year,String title){
    emit(QueryLoading());
    String year = condition1 == "Year"?firstConditionController.text:secondConditionController.text;
    String title = condition2 == "Title"?secondConditionController.text:firstConditionController.text;

    for (var element in moviesList) {
      if (int.parse(element.year) == int.parse(year) || element.title.startsWith(title.toUpperCase()) ) {
        queryMovies.add(element);
      }
    }
    if (queryMovies.isEmpty) {
      emit( QueryEmpty());
      Navigator.push(context, MaterialPageRoute(builder: (context) => QueryResultScreen(),));

      return;

    }
    emit(QueryAfterFilter(moviesList: queryMovies));
    Navigator.push(context, MaterialPageRoute(builder: (context) => QueryResultScreen(),));

    queryMovies = [];

  }

}
