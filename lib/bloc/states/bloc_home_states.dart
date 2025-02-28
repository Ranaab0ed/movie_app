abstract class HomeStates {}

class HomeInitState extends HomeStates {}

/////////////////////// All Movies /////////////////////
class HomeGetSuccessState extends HomeStates {}

class HomeGetLoadingState extends HomeStates {}

class HomeGetErrorState extends HomeStates {}

/////////////////////// Movies Available Now /////////////////////
class HomeGetSuccessStateMAN extends HomeStates {}

class HomeGetLoadingStateMVN extends HomeStates {}

class HomeGetErrorStateMVN extends HomeStates {}
