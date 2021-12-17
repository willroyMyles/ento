import 'package:firebase_auth/firebase_auth.dart';

extension UserExtension on User {
  toLocalUserMap() {
    return {
      "externalId": this.uid,
      "email": this.email,
      "username": this.displayName
    };
  }
}
