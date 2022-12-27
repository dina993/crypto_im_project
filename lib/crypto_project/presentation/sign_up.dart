import 'package:clean_arch_udemy/crypto_project/provider/register_provider.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/app_constants.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/routes.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetsManger.lockImage,
              scale: 20,
            ),
            const SizedBox(
              width: AppConstants.s16,
            ),
            const Text(AppStrings.title),
          ],
        ),
      ),
      body: Consumer<UserProvider>(builder: (context, provider, widget) {
        return SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(AppValues.p15),
                padding: const EdgeInsets.all(AppValues.m10),
                child: Form(
                  key: provider.registerKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: AppConstants.s20,
                        ),
                        Text(
                          AppStrings.signUpPage,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                            height: 300,
                            child: Image.asset(AssetsManger.logoImage)),
                        TextFunctions.user(context, provider.email,
                            label: AppStrings.email,
                            icon: const Icon(Icons.email_outlined),
                            validationFunction: provider.emailValidation),
                        TextFunctions.user(context, provider.password,
                            label: AppStrings.password,
                            icon: GestureDetector(
                              onTap: () => provider.showPass(),
                              child: Icon(
                                provider.showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            obscure: !provider.showPassword,
                            validationFunction: provider.nullValidation),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                            child: const Text(AppStrings.signUp),
                            onPressed: () {
                              if (provider.registerKey.currentState!
                                  .validate()) {
                                provider.registerKey.currentState!.save();
                                provider.registerUser(context);
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(AppStrings.doHaveAccount),
                            TextButton(
                                onPressed: () => AppRouter.router
                                    .pushToNewWidget(Login(), context),
                                child: Text(
                                  AppStrings.login,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ))
                          ],
                        ),
                      ]),
                )));
      }),
    );
  }
}
