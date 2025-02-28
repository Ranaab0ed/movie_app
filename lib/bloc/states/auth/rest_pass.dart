abstract class RestPassStates {}

class RestPassInitState extends RestPassStates {}

class RestPasLoadingState extends RestPassStates {}

class RestPassErrorState extends RestPassStates {
  String? error;
  RestPassErrorState({this.error});
}

class RestPassSuccessState extends RestPassStates {}
