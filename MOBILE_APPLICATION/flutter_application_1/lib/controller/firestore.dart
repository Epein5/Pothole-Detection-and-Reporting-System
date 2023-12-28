import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/popupmessage.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class SendDetails {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  PopUpMessage popUpMessage = PopUpMessage();

  Future<void> sendDetails(context, LatLng latlng) async {
    // print("kitta");
    try {
      await databaseReference.child('Potholes').push().set({
        'lat': latlng.latitude,
        'lng': latlng.longitude,
      }).then((value) {
      });
      // print("Uploaded");
    } catch (error) {
      print("Error uploading data: $error");
    }
  }

  // SendDetailswithimage(
  //     BuildContext context, LocationData? latlng, imageurl) async {
  //   Reference ref = FirebaseStorage.instance
  //       .ref()
  //       .child('images/${DateTime.now().toString()}');
  //   UploadTask uploadTask = ref.putFile(imageurl);
  //   await Future.value(uploadTask).then((value) async {
  //     var newUrl = await ref.getDownloadURL();
  //     await databaseReference.child('Potholes').push().set({
  //       'lat': latlng?.latitude,
  //       'lng': latlng?.longitude,
  //       'imageurl': newUrl,
  //     }).onError((error, stackTrace) {
  //       popUpMessage.flushbarmessage(context, "ERROR", '$error');
  //     }).then((value) {
  //       popUpMessage.flushbarmessage(context, "Pothole Detected",
  //           "Pothole Reported at ${latlng?.latitude.toString()}: ${latlng?.longitude.toString()}");
  //     });
  //   });
  // }
  SendDetailswithimage(
      BuildContext context, LocationData? latlng, File imageFile) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toString()}');

    try {
      // Upload the image file to Firebase Storage
      // UploadTask uploadTask = ref.putFile(imageFile);

      // Await for the upload to complete
      // TaskSnapshot taskSnapshot = await uploadTask;

      // Get the storage URL
      // String imageUrl = await ref.getDownloadURL();

      // Store the URL and location data in Firebase Realtime Database
      await databaseReference.child('Potholes').push().set({
        'lat': latlng?.latitude,
        'lng': latlng?.longitude,
        // 'imageurl': imageUrl,
      });

      // Show success message
      // ignore: use_build_context_synchronously
      popUpMessage.flushbarmessage(context, "Pothole Detected",
          "Pothole Reported at ${latlng?.latitude.toString()}: ${latlng?.longitude.toString()}");
    } catch (error) {
      // Show error message if there's an issue
      // ignore: use_build_context_synchronously
      popUpMessage.flushbarmessage(context, "ERROR", '$error');
    }
  }
}
