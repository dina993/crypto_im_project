import 'package:clean_arch_udemy/crypto_project/provider/encrypt_provider.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/app_constants.dart';
import 'package:dart_des/dart_des.dart';
import 'package:encrypt/encrypt.dart' hide Key;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/widgets.dart';

class CryptoPageView extends StatefulWidget {
  const CryptoPageView({Key? key}) : super(key: key);

  @override
  State<CryptoPageView> createState() => _CryptoPageViewState();
}

class _CryptoPageViewState extends State<CryptoPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
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
        body: Consumer<EncryptProvider>(builder: (context, provider, widget) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.all(AppValues.m10),
              padding: const EdgeInsets.all(AppValues.p15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(AssetsManger.backImage),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(AppConstants.imageOpacity),
                      BlendMode.dstATop),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppConstants.s20,
                  ),
                  Text(
                    AppStrings.dropDownTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppValues.m10),
                    child: DropdownButton(
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(AppValues.p15),
                      value: provider.dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: provider.items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() => provider.dropdownValue = newValue!);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppConstants.s20,
                  ),
                  Text(
                    AppStrings.subTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: AppConstants.s20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppValues.m10),
                    child: DropdownButton(
                      hint: const Text(AppStrings.chooseKeyLength),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(AppValues.p15),
                      value: provider.dropdownKeyValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: provider.modeOperation.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() => provider.dropdownKeyValue = newValue!);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: AppConstants.s20,
                  ),
                  Text(
                    AppStrings.dropDownTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () => provider.selectImage(),
                          child: Padding(
                            padding: const EdgeInsets.all(AppValues.m10),
                            child: Container(
                              height: AppConstants.imageHeight,
                              width: AppConstants.imageWidth,
                              child: provider.image == null
                                  ? Image.asset(AssetsManger.pickImage)
                                  : Image.file(
                                      provider.image!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(AppValues.m10),
                        child: Container(
                          height: AppConstants.imageHeight,
                          width: AppConstants.imageWidth,
                          child: provider.headedBitmap == null
                              ? Container(color: AppColor.grey)
                              : Image.memory(
                                  provider.headedBitmap!,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppConstants.s20,
                  ),
                  Text(
                    provider.image != null
                        ? "File Size: ${provider.fileSize()} MB"
                        : "",
                    style: const TextStyle(
                      fontSize: FontSize.s14,
                      color: AppColor.black,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppValues.m10),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (provider.dropdownValue == AppStrings.aes &&
                              provider.dropdownKeyValue == AppStrings.cbcMode) {
                            provider.encryptFile(
                                provider.image!.readAsBytesSync(), AESMode.cbc);
                          } else if (provider.dropdownValue == AppStrings.aes &&
                              provider.dropdownKeyValue == AppStrings.ecbMode) {
                            print('using ECB Mode Operation');
                            provider.encryptFile(
                                provider.image!.readAsBytesSync(), AESMode.ecb);
                          } else if (provider.dropdownValue == AppStrings.des &&
                              provider.dropdownKeyValue == AppStrings.cbcMode) {
                            print('using DES with  CBC Mode Operation');
                            provider.desEncrypt(
                                provider.image!.readAsBytesSync(), DESMode.CBC);
                          } else if (provider.dropdownValue == AppStrings.des &&
                              provider.dropdownKeyValue == AppStrings.ecbMode) {
                            provider.desEncrypt(
                                provider.image!.readAsBytesSync(), DESMode.ECB);
                          }
                        },
                        child: const Text(AppStrings.encryption)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppValues.m10),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (provider.dropdownValue == AppStrings.aes &&
                            provider.dropdownKeyValue == AppStrings.cbcMode) {
                          provider.decryptImage = await provider.getFile(
                              provider.image!.path, AESMode.cbc);
                          provider.sendAESImage(context);
                        } else if (provider.dropdownValue == AppStrings.aes &&
                            provider.dropdownKeyValue == AppStrings.ecbMode) {
                          provider.getFile(provider.image!.path, AESMode.ecb);
                          provider.sendAESImage(context);
                        } else if (provider.dropdownValue == AppStrings.des &&
                            provider.dropdownKeyValue == AppStrings.cbcMode) {
                          provider.desDecrypt(DESMode.CBC);
                          provider.sendDESImage(context);
                        }
                        if (provider.dropdownValue == AppStrings.des &&
                            provider.dropdownKeyValue == AppStrings.ecbMode) {
                          provider.desDecrypt(DESMode.ECB);
                          provider.sendDESImage(context);
                        }
                        TextFunctions.showToast('Send unsuccessfully.');
                      },
                      child: const Text(AppStrings.save),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppValues.m10),
                    child: ElevatedButton(
                        onPressed: () async {
                          provider.clear();
                        },
                        child: const Text(AppStrings.clear)),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
