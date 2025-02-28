abstract class DetailsMovieStates {}

class DetailsMovieStatesIni extends DetailsMovieStates {}

class DetailsMovieLoadingState extends DetailsMovieStates {}

class DetailsMovieSuccessState extends DetailsMovieStates {}

class DetailsMovieErrorState extends DetailsMovieStates {
  final String? error;
  DetailsMovieErrorState({this.error});
}
