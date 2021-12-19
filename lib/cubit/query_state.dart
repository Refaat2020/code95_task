part of 'query_cubit.dart';

abstract class QueryState extends Equatable {
  const QueryState();
}

class QueryInitial extends QueryState {
  @override
  List<Object> get props => [];
}

class QueryLoading extends QueryState {
  @override
  List<Object> get props => [];
}

class QueryFetched extends QueryState {
 final List<MovieItems>moviesList;


  const QueryFetched({required this.moviesList});

  @override
  List<Object> get props => [];
}

class QueryAfterFilter extends QueryState {
  final List<MovieItems>moviesList;


  const QueryAfterFilter({required this.moviesList});

  @override
  List<Object> get props => [];
}

class QueryEmpty extends QueryState {


  const QueryEmpty();

  @override
  List<Object> get props => [];
}
class ChangeCondition extends QueryState {


  const ChangeCondition();

  @override
  List<Object> get props => [];
}

class QueryError extends QueryState {
  @override
  List<Object> get props => [];
}


