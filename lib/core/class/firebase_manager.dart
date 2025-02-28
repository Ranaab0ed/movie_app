import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/model/user_model.dart';

class FirebaseManager {
  static Future<void> createAccount(
      {required String emailAddress,
      required String password,
      required String name,
      required String phone,
      required String avatar,
      required Function onLoading,
      required Function onSuccess,
      required Function onError}) async {
    try {
      onLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      UserModel user = UserModel(
          name: name, email: emailAddress, phone: phone, avatar: avatar);
      addUser(user);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.code);
      } else if (e.code == 'email-already-in-use') {
        onError(e.code);
      }
    } catch (e) {
      onError("Some thing is Wrong");
    }
  }

  static Future<void> logIn(
      {required String emailAddress,
      required String password,
      required Function onLoading,
      required Function onSuccess,
      required Function onError}) async {
    try {
      onLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError("Invalid Email Or Password");
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<UserModel>(
      fromFirestore: (model, options) {
        return UserModel.fromJson(model.data()!);
      },
      toFirestore: (user, options) {
        return UserModel.toJson(user);
      },
    );
  }

  static Future<void> addUser(UserModel user) {
    var collection = getUserCollection();
    var docRef = collection.doc();
    user.id = docRef.id;
    return docRef.set(user);
  }
}
