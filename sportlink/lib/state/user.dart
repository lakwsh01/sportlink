import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:sportlink/model/model.dart' as gd;

class UserState {
  gd.User? gdUser;
  firebase.User? fbUser;
  UserState({this.fbUser, this.gdUser});

  void userUpdate({required firebase.User? fbUser, required gd.User? gdUser}) {
    this.fbUser = fbUser;
    this.gdUser = gdUser;
  }

  void userLogout() {
    fbUser = null;
    gdUser = null;
  }

  Future<String>? get firebsaeAuthTokent => fbUser?.getIdToken();
}
