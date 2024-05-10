import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plan_apps/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

    try {
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    googleSignIn.signOut();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
