import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final firebaseStorageRepositoryProvider = Provider((ref) =>
    FirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance));

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageRepository({required this.firebaseStorage});

  storageFileToFirebase(String ref, var file) async {
    UploadTask? uploadTask;
    if (file is File) {
      uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    }
    if (file is Uint8List) {
      final tempDir = await getTemporaryDirectory();
      File fileTemp =
          await File('${tempDir.path}/image${DateTime.timestamp()}.png')
              .create();
      fileTemp.writeAsBytesSync(file);
      uploadTask = firebaseStorage.ref().child(ref).putFile(fileTemp);
    }

    TaskSnapshot snapshot = await uploadTask!;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
