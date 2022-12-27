import 'dart:async';
import 'dart:io';

import 'package:bitmap/bitmap.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/app_constants.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/helper.dart';
import 'package:clean_arch_udemy/crypto_project/utilities/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_des/dart_des.dart';
import 'package:encrypt/encrypt.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EncryptProvider extends ChangeNotifier {
  File? image;
  String? newImage;
  String? decryptImage;
  File? displayImage;
  File? aesEncryptFile;
  File? aesDecryptFile;
  File? desEncryptFile;
  File? desDecryptFile;
  List<int>? encryptedDES;
  List<int>? decryptedDES;
  String? imageEncryptUrl;
  Encrypted? encryptedFile;
  String dropdownValue = AppStrings.aes;
  String dropdownKeyValue = AppStrings.cbcMode;
  var items = [AppStrings.aes, AppStrings.des];
  var modeOperation = [AppStrings.cbcMode, AppStrings.ecbMode];
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final keyAES = Key.fromSecureRandom(16);
  final ivAES = IV.fromLength(16);
  final keyDES = '12345674'; // 8-byte for DES
  var ivDES = [1, 2, 3, 4, 5, 6, 7, 8];
  XFile? pickedFile;
  dynamic headedBitmap;
  dynamic desHeadedBitmap;

  fileSize() {
    final fileSize = image != null
        ? (image!.lengthSync().roundToDouble() / 1048576).toStringAsFixed(2)
        : "";
    return fileSize;
  }

////////////AES//////////////////////////
  _fromUint8List(Uint8List bytes) {
    Bitmap bitmap = Bitmap.fromHeadful(60, 60, bytes);
    notifyListeners();
    return bitmap;
  }

  Future<Uint8List?> encryptFile(data, AESMode mod) async {
    final directory = await getExternalStorageDirectory();
    final encrypter = Encrypter(AES(keyAES, mode: mod));
    encryptedFile = encrypter.encryptBytes(data, iv: ivAES);
    Bitmap bitmapImg = _fromUint8List(encryptedFile!.bytes);
    Bitmap contrastedBitmap = bitmapImg.apply(BitmapContrast(0.2));
    headedBitmap = contrastedBitmap.buildHeaded();
    aesEncryptFile =
        await File('${directory!.path}/aes.jpg').writeAsBytes(headedBitmap);
    TextFunctions.showToast(
        'The Encryption has been completed unsuccessfully.');
    notifyListeners();
    return encryptedFile!.bytes;
  }

  saveFileEncrypted(String path, Uint8List byte) async {
    String fileSave = await FileSaver.instance.saveAs(image!.path, byte, "aes",
        MimeType.OTHER); //Saving the encrypted file to the local storage
    return fileSave;
  }

  Future<String?> getFile(String filePath, AESMode mod) async {
    final directory = await getExternalStorageDirectory();
    // Uint8List? encryptedData = await readImageFile(image!);
    List<int> palinData = await decryptFile(encryptedFile!.bytes, mod);
    decryptImage = await writeData(palinData, filePath);
    aesDecryptFile = await File('${directory!.path}/test.jpg')
        .writeAsBytes(Uint8List.fromList(palinData));
    print(aesDecryptFile);
    notifyListeners();
    return decryptImage;
  }

  decryptFile(Uint8List encryptedImage, AESMode mod) {
    Encrypted encrypt = Encrypted(encryptedImage);
    final encrypted = Encrypter(AES(
      keyAES,
      mode: mod,
    ));
    return encrypted.decryptBytes(encrypt, iv: ivAES);
  }

  Future<Uint8List?> readImageFile(File imageFile) async {
    if (!(await imageFile.exists())) {
      return null;
    }
    return await imageFile.readAsBytes();
  }

  Future<String> writeData(data, filePath) async {
    File f = File(filePath);
    await f.writeAsBytes(data);
    return f.absolute.toString();
  }

  Future<File> getImageFile(String imageName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return File(appDocDir.path + imageName);
    // File(appDocDir.path + Platform.pathSeparator + imageName);
  }

  Future<File?> selectImage() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    notifyListeners();
    return image;
  }

  Future<String> uploadImage(String path) async {
    String imageUrl =
        await FireStorageHelper.fireStorageHelper.uploadImage(image!, path);
    return imageUrl;
  }

  sendAESImage(BuildContext ctx) async {
    String imagePath = await uploadImage('images');
    await addImage(
      FirestoreHelper.fireStoreHelper.userId!,
      image!.path,
      imagePath,
      dropdownValue,
      dropdownKeyValue,
      aesEncryptFile!.path,
      aesDecryptFile!.path,
    );
  }

  clear() {
    image = null;
    headedBitmap = null;
    aesDecryptFile = null;
    notifyListeners();
  }

  addImage(
    String id,
    String imageName,
    String imagePath,
    String algorithm,
    String modeOperation,
    String encryptImage,
    String decryptedImage,
  ) async {
    DocumentReference<Map<String, dynamic>> result =
        await fireStore.collection('images').add({
      'id': id,
      'image': imageName,
      'imageStorage': imagePath,
      'algorithm': algorithm,
      'modeOperation': modeOperation,
      'encryptedFile': encryptImage,
      'decryptedFile': decryptedImage,
      "AESKey": keyAES.bytes,
      "AESIV": ivAES.bytes,
      "DESKey": keyDES,
      "DESIV": ivDES,
      // "encryptedByte": encByte
    });
    await fireStore
        .collection('images')
        .doc(result.id)
        .update({'id': result.id});
  }

  ////////////////DES ////////////////////////

  desEncrypt(data, DESMode mod) async {
    var DESkey = keyDES.split('').map(int.parse).toList();
    final directory = await getExternalStorageDirectory();
    try {
      DES desCBC = DES(
        key: DESkey,
        mode: mod,
        iv: ivDES,
      );
      List<int> bytes = image!.readAsBytesSync();
      print('orginal$bytes');
      encryptedDES = desCBC.encrypt(bytes);
      Bitmap bitmapImg = _fromUint8List(Uint8List.fromList(encryptedDES!));
      Bitmap contrastedBitmap = bitmapImg.apply(BitmapContrast(0.3));
      headedBitmap = contrastedBitmap.buildHeaded();
      desEncryptFile =
          await File('${directory!.path}/des.jpg').writeAsBytes(headedBitmap);
      print('encrypted bitmap$encryptedDES');
      TextFunctions.showToast(
          'The Encryption has been completed unsuccessfully.');
      notifyListeners();
      return Uint8List.fromList(encryptedDES!);
    } catch (e) {
      rethrow;
    }
  }

  desDecrypt(DESMode mod) async {
    var desKey = keyDES.split('').map(int.parse).toList();
    final directory = await getExternalStorageDirectory();
    DES desCBC = DES(
      key: desKey,
      mode: mod,
    );

    decryptedDES = desCBC.decrypt(Uint8List.fromList(encryptedDES!));
    desDecryptFile = await File('${directory!.path}/test.jpg')
        .writeAsBytes(Uint8List.fromList(decryptedDES!));
    Uint8List? encrypted = await desDecryptFile!.readAsBytes();
    print(encrypted);
    print('decrypted bitmap : ${(decryptedDES!)}');
    return decryptedDES;
  }

  ////////////////////////////////////

  sendDESImage(BuildContext ctx) async {
    String imagePath = await uploadImage('images');
    await addImage(
      FirestoreHelper.fireStoreHelper.userId!,
      image!.path,
      imagePath,
      dropdownValue,
      dropdownKeyValue,
      desEncryptFile!.path,
      desDecryptFile!.path,
    );
  }
}
