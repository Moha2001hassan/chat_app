import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user_model.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // تسجيل مستخدم جديد
  Future<String?> registerWithEmail({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String image,
  }) async {
    try {
      // إنشاء الحساب
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // إرسال بريد التفعيل
      await sendVerificationEmail();

      // حفظ البيانات على Firestore
      final userId = userCredential.user!.uid;
      final user = UserModel(
        id: userId,
        name: name,
        phone: phone,
        email: email,
        image: image,
      );

      await _firestore.collection('users').doc(userId).set(user.toJson());

      return null; // نجاح
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'حدث خطأ غير متوقع';
    }
  }

  // تسجيل الدخول
  Future<String?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!_auth.currentUser!.emailVerified) {
        return 'يرجى تفعيل البريد الإلكتروني أولًا';
      }

      return null; // نجاح
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'حدث خطأ أثناء تسجيل الدخول';
    }
  }

  // إرسال كود التفعيل
  Future<void> sendVerificationEmail() async {
    final user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // تسجيل الخروج
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // المستخدم الحالي
  User? get currentUser => _auth.currentUser;
}

