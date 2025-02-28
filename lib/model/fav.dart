class FavModel {
  String? message;
  List<DataFav>? data;

  FavModel({this.message, this.data});

  FavModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <DataFav>[];
      json['data'].forEach((v) {
        data!.add(new DataFav.fromJson(v));
      });
    }
  }
}

class DataFav {
  String? movieId;
  String? name;
  num? rating;
  String? imageURL;
  String? year;

  DataFav({this.movieId, this.name, this.rating, this.imageURL, this.year});

  DataFav.fromJson(Map<String, dynamic> json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }
}
