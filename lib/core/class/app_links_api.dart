class AppLinksApi {
/////////////// domain ///////////
  static const String link = "https://route-movie-apis.vercel.app";

  //////////////////////// home //////////////
  static const String getALlMovies = "https://yts.mx/api/v2/list_movies.json";
//------------------------ get movies Available Now ---------//
  static const String getMoviesAvailableNow =
      "https://yts.mx/api/v2/list_movies.json?sort_by=year";

//------------------------ get movie Details ---------//
  static const String getMovieDetails =
      "https://yts.mx/api/v2/movie_details.json?movie_id=66664&with_cast=true&with_images=true";

  ///---------------------- get profile ------------------//
  static const String getProfile = "$link/profile";
////------------------------rest pass ------------------///
  static const String restPass = "$link/auth/reset-password";
  //------------------------ add fav ------------------//
  static const String addFav = "$link/favorites/add";
  //------------------------ remove fav ------------------//
  static const String removeFav = "$link/favorites/remove/";

  //------------------------ remove fav ------------------//
  static const String isFav = "$link/favorites/is-favorite/";

  //------------------------ remove fav ------------------//
  static const String getFav = "$link/favorites/all";
}
