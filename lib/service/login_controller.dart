import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_laravel/model/user_details_models.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController with ChangeNotifier {
  // obj
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserModel? userDetails;

  // func for google login
  googleLogin() async {
    this.googleSignInAccount = await _googleSignIn.signIn();

    // insert val to userDetails model
    this.userDetails = new UserModel(
      displayName: this.googleSignInAccount!.displayName,
      email: this.googleSignInAccount!.email,
      photoURL: this.googleSignInAccount!.photoUrl,
    );

    notifyListeners();
  }

  logOut() async {
    // empty after logout
    this.googleSignInAccount = await _googleSignIn.signOut();

    userDetails = null;

    // call listener
    notifyListeners();
  }
}
