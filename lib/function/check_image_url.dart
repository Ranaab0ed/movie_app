import 'package:http/http.dart' as http;

Future<bool> checkImageUrl(String imageUrl) async {
  try {
    final res = await http.head(Uri.parse(imageUrl));
    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}
