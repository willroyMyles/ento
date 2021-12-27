import 'package:ento/backend/network/baseCalls.dart';
import 'package:ento/services/storage.service.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin AuthMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  BaseCalls bs = BaseCalls();

  void logOut() async {
    try {
      await auth.signOut();
      storeage.store.remove("uid");
    } catch (e) {
      print(e);
    }
  }

  // Future<UserCredential> authSignUpWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     storeage.store.write("uid", userCredential.user!.uid);
  //     return Future.value(userCredential);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //     return Future.error(e.code);
  //   } catch (e) {
  //     print(e);
  //     return Future.error("unknown error");
  //   }
  // }

  Future authSignUpWithEmailAndPassword(String email, String password,
      {isCompany = false}) async {
    try {
      var res = await bs.dio.post("${bs.baseUrl}${bs.userEndpoint}/register",
          data: {"email": email, "password": password, "isCompany": isCompany});
      return Future.value(res.data);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return Future.error(e.code);
    } catch (e) {
      print(e);
      return Future.error("unknown error");
    }
  }

  // authSignInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     storeage.store.write("uid", userCredential.user!.uid);
  //     return Future.value(userCredential);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }

  //     return Future.value(null);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  authSignInWithEmailAndPassword(String email, String password) async {
    try {
      var res = await bs.dio.post("${bs.baseUrl}${bs.userEndpoint}/login",
          data: {"email": email, "password": password});
      return Future.value(res.data);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

      return Future.value(null);
    } catch (e) {
      print(e);
    }
  }
}
