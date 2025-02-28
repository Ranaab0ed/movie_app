abstract class SimilerSates {}

class SimilerMovesInitStates extends SimilerSates {}

class SimilerSuccessState extends SimilerSates {}

class SimilerLoadingState extends SimilerSates {}

class SimilerErrorState extends SimilerSates {
  String? error;
  SimilerErrorState({this.error});
}
