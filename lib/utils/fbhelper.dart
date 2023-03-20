import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FB_Helper {
  static FB_Helper fb_helper = FB_Helper();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth firebase = FirebaseAuth.instance;

  //login & register
  Future<bool> sign_up(String email, String password) async {
    bool iscreate = false;
    await firebase
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      iscreate = true;
      print('success');
    }).catchError((error) {
      iscreate = false;
      print(error);
    });
    return iscreate;
  }

  Future<bool> sign_in(String email, String password) async {
    bool issignin = false;
    await firebase
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      issignin = true;
      print('success');
    }).catchError((error) {
      issignin = false;
      print(error);
    });
    return issignin;
  }

  //check login-user
  Future<bool> checkUser() async {
    FirebaseAuth firebase = FirebaseAuth.instance;
    if (await firebase.currentUser != null) {
      return true;
    }
    return false;
  }

  //check logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  //login via google
  Future<bool> signInWithGoogle() async {
    bool islogin = false;
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
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      islogin = true;
    }).catchError((error) {
      islogin = false;
    });
    return islogin;
  }

  void UserDetail(){
    User? Userid = firebase.currentUser;
  }
  //add data
  Future<void> addData(
      {required String name,
      String? disc,
      required String category,
      required String image,
      required String price}) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('product').add({
      "category": category,
      "image": image,
      "name": name,
      "price": price,
      "disc": disc,
      "cart": false,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readData() {
    return firebaseFirestore.collection('product').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readcetData(String cat) {
    return firebaseFirestore
        .collection('product')
        .where('category', whereIn: [cat]).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readnameData(String name) {
    return firebaseFirestore
        .collection('product')
        .where('name', whereIn: [name]).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readCartData() {
    return firebaseFirestore
        .collection('product')
        .where('cart', isEqualTo: true)
        .snapshots();
  }

  void deleteData(String id) {
    firebaseFirestore.collection('product').doc(id).delete();
  }

  Future<bool> updateData(
      {required String name,
      required String disc,
      required String id,
      required bool iscart,
      required String category,
      required String image,
      required String price}) async {
    bool isCart = false;
    await firebaseFirestore.collection('product').doc(id).update({
      "cart": iscart,
      "category": category,
      "image": image,
      "name": name,
      "price": price,
      "disc": disc,
    }).then(
      (value) {
        isCart = true;
      },
    ).catchError((error) {
      isCart = false;
    });
    return isCart;
  }
}



// Future<void> addData(
//     {required String name,
//       String? disc,
//       required String category,
//       required String image,
//       required String price}) async {
//   UserDetail();
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   await firebaseFirestore.collection("Users").doc(userid).collection('product').add({
//     "category": category,
//     "image": image,
//     "name": name,
//     "price": price,
//     "disc": disc,
//     "cart": false,
//   });
// }
//
// Stream<QuerySnapshot<Map<String, dynamic>>> readData() {
//   UserDetail();
//   return firebaseFirestore.collection("Users").doc(userid).collection('product').snapshots();
// }
//
// Stream<QuerySnapshot<Map<String, dynamic>>> readcetData(String cat) {
//
//   return firebaseFirestore.collection("Users").doc(userid)
//       .collection('product')
//       .where('category', whereIn: [cat]).snapshots();
// }
//
// Stream<QuerySnapshot<Map<String, dynamic>>> readnameData(String name) {
//   return firebaseFirestore.collection("Users").doc(userid)
//       .collection('product')
//       .where('name', whereIn: [name]).snapshots();
// }
//
// Stream<QuerySnapshot<Map<String, dynamic>>> readCartData() {
//   return firebaseFirestore.collection("Users").doc(userid)
//       .collection('product')
//       .where('cart', isEqualTo: true)
//       .snapshots();
// }
//
// void deleteData(String id) {
//   firebaseFirestore.collection('product').doc(id).delete();
// }
//
// Future<bool> updateData(
//     {required String name,
//       required String disc,
//       required String id,
//       required bool iscart,
//       required String category,
//       required String image,
//       required String price}) async {
//   bool isCart = false;
//   await firebaseFirestore.collection("Users").doc(userid).collection('product').doc(id).update({
//     "cart": iscart,
//     "category": category,
//     "image": image,
//     "name": name,
//     "price": price,
//     "disc": disc,
//   }).then(
//         (value) {
//       isCart = true;
//     },
//   ).catchError((error) {
//     isCart = false;
//   });
//   return isCart;
// }
//