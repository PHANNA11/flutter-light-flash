import 'package:first_app/auth/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserController {
  Future<List<UserModel>> getUserData() async {
    dynamic respon;
    try {
      var url = 'https://fakestoreapi.com/users';
      var respon = await http.get(Uri.parse(url));
      if (respon.statusCode == 200) {
        return userModelFromJson(respon.body);
      } else {
        print(respon.statusCode.toString());
      }
    } catch (e) {
      print(e);
    }
    return userModelFromJson(respon.body);
  }
}
