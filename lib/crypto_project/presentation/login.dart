import 'package:clean_arch_udemy/crypto_project/presentation/sign_up.dart';
import 'package:clean_arch_udemy/crypto_project/provider/register_provider.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/app_constants.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/routes.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

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
        )),
        body: Consumer<UserProvider>(builder: (context, provider, widget) {
          return SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(AppValues.p15),
                padding: const EdgeInsets.all(AppValues.m10),
                child: Form(
                  key: provider.loginKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: AppConstants.s20,
                        ),
                        Text(
                          AppStrings.loginPage,
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
                          height: 20,
                        ),
                        ElevatedButton(
                            child: const Text(AppStrings.login),
                            onPressed: () {
                              if (provider.loginKey.currentState!.validate()) {
                                provider.loginKey.currentState!.save();
                                provider.login(context);
                              }
                            }),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(AppStrings.haveAccount),
                            TextButton(
                                onPressed: () => AppRouter.router
                                    .pushToNewWidget(SignUp(), context),
                                child: Text(
                                  AppStrings.signUp,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ))
                          ],
                        ),
                      ]),
                )),
          );
        }));
  }
}
