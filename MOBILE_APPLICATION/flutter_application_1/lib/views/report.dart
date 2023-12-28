import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/firestore.dart';
import 'package:flutter_application_1/utils/popupmessage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class ReportPotholeView extends StatefulWidget {
  const ReportPotholeView({super.key});

  @override
  State<ReportPotholeView> createState() => _ReportPotholeViewState();
}

class _ReportPotholeViewState extends State<ReportPotholeView> {
  Location location = Location();
  LocationData? _locationData;
  PopUpMessage popUpMessage = PopUpMessage();

  @override
  void initState() {
    super.initState();
    loadmodel();
  }

  detect_image(File image) async {
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 4,
        threshold: 0.001,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _predictions = prediction!;
      print(_predictions);
    });
  }

  bool _loading = true;
  late File _image;
  final imagePicker = ImagePicker();
  List _predictions = [];

  loadmodel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/label.txt');
  }

  _loadimagefromgallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detect_image(_image);
  }

  _loadimagefromcamera() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);

    if (image == null) {
      return null;
    } else {
      _image = File(image.path);
    }
    detect_image(_image);
  }

  Future<void> retrieveLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Location services are disabled.');
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location permission denied.');
        return;
      }
    }

    _locationData = await location.getLocation();
    setState(() {
      _locationData = _locationData;
    });
  }

  Widget build(BuildContext context) {
    SendDetails sendDetails = SendDetails();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 300,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 243, 241, 241)),
                width: double.infinity,
                child: Center(
                  child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          color: Color.fromARGB(255, 224, 115, 244)),
                      child: const Center(
                        child: Text(
                          'Report Potholes in your Area',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Click or Select Potholes Image",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _loadimagefromgallery();
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 224, 115, 244),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Center(child: Text('Check with Image')),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                _loadimagefromcamera();
              },
              child: Container(
                height: 50,
                width: 300,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 224, 115, 244),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Center(child: Text('Check with Camera')),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _loading == false
                ? Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.file(_image),
                      ),
                      Text(_predictions[0]['label']
                              .toString()
                              .substring(1)
                              .isNotEmpty
                          ? _predictions[0]['label'].toString().substring(1)
                          : "No Pothole Detected"),
                      Text(
                          'Confidence ${_predictions[0]['confidence'].toString().substring(2, 4)}.${_predictions[0]['confidence'].toString().substring(4, 6)}%'),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      _predictions[0]['label'].toString().substring(1) ==
                              ' Pothole'
                          ? GestureDetector(
                              onTap: () async {
                                popUpMessage.flushbarmessage(context,
                                    "Wait for a moment", "Sending Details");
                                await retrieveLocation();
                                // ignore: use_build_context_synchronously

                                // ignore: use_build_context_synchronously
                                sendDetails
                                    .sendDetails(
                                        context,
                                        LatLng(_locationData!.latitude!,
                                            _locationData!.longitude!))
                                    .then((value) {
                                  Navigator.pop(context);
                                  popUpMessage.flushbarmessage(
                                      context,
                                      "Thanks for you contribution",
                                      "Successfully Reported");
                                });
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const ReportPotholeView()));
                              },
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: const Center(
                                    child: Text(
                                  'Report Pothole',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          : const SizedBox(
                              height: 30,
                              child: Text("No pothole Detected"),
                            ),
                    ],
                  )
                : const Icon(Icons.error_outline),
          ],
        ),
      ),
    );
  }
}
