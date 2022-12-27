import 'package:clean_arch_udemy/crypto_project/presentation/login.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../presentation/crypto_page.dart';
import '../utilities/auth_helper.dart';
import '../utilities/helper.dart';
import '../utilities/routes.dart';
import '../utilities/user_model.dart';

class UserProvider extends ChangeNotifier {
  bool showPassword = true;
  final registerKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  registerUser(BuildContext context) async {
    try {
      if (registerKey.currentState!.validate()) {
        User? user =
            await AuthHelper.authHelper.register(email.text, password.text);
        UserModel userModels = UserModel(user!.uid, email.text, password.text);
        FirestoreHelper.fireStoreHelper.createNewUser(userModels, user.uid);
        AppRouter.router.push(Login(), context);
        // getCurrentUser();
      } else {
        return;
      }
    } catch (e) {
      TextFunctions.showToast(e.toString());
    }
  }

  login(BuildContext context) async {
    try {
      if (loginKey.currentState!.validate()) {
        User? user =
            await AuthHelper.authHelper.login(email.text, password.text);
        await FirestoreHelper.fireStoreHelper.getUser(user!.uid, context);
        FirestoreHelper.fireStoreHelper.getCurrentUser(context);
        TextFunctions.showToast('Login Successfully..');
        AppRouter.router.push(CryptoPageView(), context);
      } else {
        return;
      }
    } catch (e) {
      TextFunctions.showToast(e.toString());
    }
  }

  emailValidation(String value) {
    if (value.isEmpty) {
      return 'حقل مطلوب';
    } else if (!isEmail(value)) {
      return 'الايميل غير صحيح';
    }
  }

  nullValidation(String value) {
    if (value.isEmpty) {
      return 'حقل مطلوب';
    } else if (value.length < 6) {
      return "النص الذي تم إدخاله يجب أن يكون أكثر من 6 حروف";
    }
  }

  showPass() {
    showPassword = !(showPassword);
    notifyListeners();
  }
}
