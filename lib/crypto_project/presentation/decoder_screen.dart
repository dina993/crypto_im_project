// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dart_des/dart_des.dart';
// import 'package:encrypt/encrypt.dart' hide Key;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../provider/encrypt_provider.dart';
// import '../utilities/app_constants.dart';
// import '../utilities/widgets.dart';
//
// class DecoderPageView extends StatefulWidget {
//   const DecoderPageView({Key? key}) : super(key: key);
//
//   @override
//   State<DecoderPageView> createState() => _DecoderPageViewState();
// }
//
// class _DecoderPageViewState extends State<DecoderPageView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 AssetsManger.lockImage,
//                 scale: 20,
//               ),
//               const SizedBox(
//                 width: AppConstants.s16,
//               ),
//               const Text(AppStrings.decoderTitle),
//             ],
//           ),
//         ),
//         body: Consumer<EncryptProvider>(builder: (context, provider, widget) {
//           return SingleChildScrollView(
//               child: Container(
//                   // height: 900,
//                   margin: const EdgeInsets.all(AppValues.m10),
//                   padding: const EdgeInsets.all(AppValues.p15),
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: const AssetImage(AssetsManger.backImage),
//                       fit: BoxFit.cover,
//                       colorFilter: ColorFilter.mode(
//                           Colors.black.withOpacity(AppConstants.imageOpacity),
//                           BlendMode.dstATop),
//                     ),
//                   ),
//                   child: StreamBuilder<QuerySnapshot?>(
//                       stream: FirebaseFirestore.instance
//                           .collection('images')
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData) {
//                           return const Center(
//                             child: Text('there is no orders'),
//                           );
//                         } else {
//                           return ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               scrollDirection: Axis.vertical,
//                               itemCount: snapshot.data!.docs.length,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const SizedBox(
//                                         height: AppConstants.s20,
//                                       ),
//                                       Text(
//                                         AppStrings.decryptTitle,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleMedium,
//                                       ),
//                                       const SizedBox(
//                                         height: AppConstants.s20,
//                                       ),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(
//                                                 AppValues.m10),
//                                             child: SizedBox(
//                                               height: AppConstants.imageHeight,
//                                               width: AppConstants.imageWidth,
//                                               child: snapshot.data!.docs[index]
//                                                           ['encryptedFile'] ==
//                                                       null
//                                                   ? Container(
//                                                       color: AppColor.grey)
//                                                   : Image.file(
//                                                       File(snapshot
//                                                               .data!.docs[index]
//                                                           ['encryptedFile']),
//                                                       height: 120,
//                                                       width: 120,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(
//                                                 AppValues.m10),
//                                             child: SizedBox(
//                                               height: AppConstants.imageHeight,
//                                               width: AppConstants.imageWidth,
//                                               child: provider.newImage == null
//                                                   ? Container(
//                                                       color: AppColor.grey)
//                                                   : Image.file(
//                                                       File(provider.newImage!),
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Text(
//                                         '  The Algorithm  is : ${snapshot.data!.docs[index]['algorithm']}',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleMedium,
//                                       ),
//                                       Text(
//                                         '  Mode Operation is : ${snapshot.data!.docs[index]['modeOperation']}',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .titleMedium,
//                                       ),
//                                       const SizedBox(
//                                         height: AppConstants.s20,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: AppValues.p15),
//                                         child: ElevatedButton(
//                                             onPressed: () async {
//                                               if (snapshot.data!.docs[index]
//                                                           ['algorithm'] ==
//                                                       AppStrings.aes &&
//                                                   snapshot.data!.docs[index]
//                                                           ['modeOperation'] ==
//                                                       AppStrings.cbcMode) {
//                                                 provider.newImage =
//                                                     await provider.getFile(
//                                                         snapshot.data!
//                                                                 .docs[index]
//                                                             ['encryptedFile'],
//                                                         AESMode.cbc);
//
//                                                 // await provider.getFile(
//                                                 //     snapshot.data!
//                                                 //         .docs[index]['image']
//                                                 //         .toString(),
//                                                 //     AESMode.cbc);
//                                               } else if (snapshot
//                                                               .data!.docs[index]
//                                                           ['algorithm'] ==
//                                                       AppStrings.aes &&
//                                                   snapshot.data!.docs[index]
//                                                           ['modeOperation'] ==
//                                                       AppStrings.ecbMode) {
//                                                 provider.newImage =
//                                                     await provider.getFile(
//                                                         snapshot.data!
//                                                                 .docs[index]
//                                                             ['image'],
//                                                         AESMode.ecb);
//                                               } else if (snapshot
//                                                               .data!.docs[index]
//                                                           ['algorithm'] ==
//                                                       AppStrings.des &&
//                                                   snapshot.data!.docs[index]
//                                                           ['modeOperation'] ==
//                                                       AppStrings.cbcMode) {
//                                                 provider.newImage =
//                                                     await provider.desDecrypt(
//                                                         DESMode.CBC);
//                                               }
//                                               if (snapshot.data!.docs[index]
//                                                           ['algorithm'] ==
//                                                       AppStrings.des &&
//                                                   snapshot.data!.docs[index]
//                                                           ['modeOperation'] ==
//                                                       AppStrings.ecbMode) {
//                                                 provider
//                                                     .desDecrypt(DESMode.ECB);
//                                               }
//                                               TextFunctions.showToast(
//                                                   'The Decryption has been completed unsuccessfully.');
//                                             },
//                                             child: const Text(
//                                                 AppStrings.decryption)),
//                                       )
//                                     ]);
//                               });
//                         }
//                       })));
//         }));
//   }
// }
