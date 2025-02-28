abstract class SearchMoviesStates {}

class SearchMoviesInitStates extends SearchMoviesStates {}

class SearchMoviesLoadingState extends SearchMoviesStates {}

class SearchMoviesErrorStates extends SearchMoviesStates {
  String? error;
  SearchMoviesErrorStates({this.error});
}

class SearchMoviesSuccessStates extends SearchMoviesStates {}

class SearchMoviesEmptyStates extends SearchMoviesStates {}
