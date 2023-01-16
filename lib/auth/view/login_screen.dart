import 'package:first_app/auth/controller/useeController.dart';
import 'package:first_app/auth/model/user_model.dart';
import 'package:first_app/products/views/view_product_cart.dart';
import 'package:first_app/util/style.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  List<UserModel> listusers = [];
  void getUserFromAPI() async {
    await UserController().getUserData().then((value) {
      setState(() {
        listusers = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 0,
      ),
      body: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Signin Account'.toUpperCase(),
              style: styleXL,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'Enter E-mail', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passController,
              decoration: const InputDecoration(
                  hintText: 'Enter password', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  autofocus: true,
                  onPressed: () {
                    if (emailController.text.isEmpty ||
                        passController.text.isEmpty) {
                      print('Validation');
                    } else {
                      for (var element in listusers) {
                        if (element.email == emailController.text &&
                            element.password == passController.text) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductCarts(
                                  userModel: element,
                                ),
                              ),
                              (route) => false);
                        }
                      }
                    }
                  },
                  child: Text(
                    'login'.toUpperCase(),
                    style: styleL,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
