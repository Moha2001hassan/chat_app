import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthRemoteDatasource {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> register({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String image,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user!.sendEmailVerification();

    final userModel = UserModel(
      id: credential.user!.uid,
      name: name,
      phone: phone,
      image: image,
      email: email,
    );

    await _firestore.collection('users').doc(userModel.id).set(userModel.toJson());

    return userModel;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final doc = await _firestore.collection('users').doc(credential.user!.uid).get();

    return UserModel.fromJson(doc.data()!);
  }

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return UserModel.fromJson(doc.data()!);
  }
}
