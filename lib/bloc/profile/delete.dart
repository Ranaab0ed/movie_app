import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/profile/delete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteUserBloc extends Cubit<DeleteStates> {
  DeleteUserBloc() : super(DeleteInitState());

  deleteUser() async {
    try {
      emit(DeleteLoadingState());

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? '';
      Uri url = Uri.parse("https://route-movie-apis.vercel.app/profile");
      http.Response res = await http.delete(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final SharedPreferences shapref = await SharedPreferences.getInstance();

        shapref.remove("name");
        shapref.remove("email");
        shapref.remove("phone");
        shapref.remove("pass");
        shapref.remove("avaterId");
        shapref.remove("isLogin");
        shapref.remove("id");
        shapref.remove("token");
        print("---------------deleted -------------");
        print(res.body);
        emit(DeleteSuccessState());
      } else {
        print("Error : ${res.body}");
        emit(DeleteErrorState());
      }
    } catch (e) {
      print("Exception: $e");
      emit(DeleteErrorState());
    }
  }
}
