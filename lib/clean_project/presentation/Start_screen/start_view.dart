import 'package:flutter/material.dart';

import '../resourses/app_color.dart';
import '../resourses/app_strings.dart';
import '../resourses/assets_manger.dart';
import '../resourses/values_style.dart';

class StartView extends StatefulWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p150),
        margin: const EdgeInsets.all(AppMargin.m15),
        child: Column(
          children: [
            Image.asset(AssetsManger.startImage),
            const SizedBox(
              height: AppSize.s15,
            ),
            Text(
              AppStrings.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: AppSize.s15,
            ),
            Text(
              AppStrings.subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: AppSize.s15,
            ),
            ElevatedButton(
                onPressed: () {},
                style: Theme.of(context).elevatedButtonTheme.style,
                child: const Text(AppStrings.startButton))
          ],
        ),
      ),
    );
  }
}
