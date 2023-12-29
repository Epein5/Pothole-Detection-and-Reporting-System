import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/firestore.dart';
import 'package:flutter_application_1/utils/boundingbox.dart';
import 'package:flutter_application_1/utils/popupmessage.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:camera/camera.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetectedObjectsProvider extends ChangeNotifier {
  List<dynamic> _detectedObjects = [];

  List<dynamic> get detectedObjects => _detectedObjects;

  void updateDetectedObjects(List<dynamic> newObjects) {
    _detectedObjects = newObjects;
    notifyListeners();
  }
}

class ObjectDetectionScreen extends StatefulWidget {
  @override
  _ObjectDetectionScreenState createState() => _ObjectDetectionScreenState();
}

class _ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  FlutterVision vision = FlutterVision();
  CameraController? _cameraController;
  bool isDetecting = false;
  DetectedObjectsProvider _detectedObjectsProvider = DetectedObjectsProvider();
  Location location = Location();
  LocationData? _locationData;
  PopUpMessage popUpMessage = PopUpMessage();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    retrieveLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      _locationData = currentLocation;
      print(_locationData);
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    vision.closeYoloModel();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    await _cameraController?.initialize();

    if (mounted) {
      setState(() {});
      _startObjectDetection();
    }
  }

  Future<void> _startObjectDetection() async {
    await vision.loadYoloModel(
      // labels: 'assets/labels.txt',
      // modelPath: 'assets/yolov5.tflite',
      // modelVersion: 'yolov5',
      labels: 'assets/yolov8.txt',
      modelPath: 'assets/yolov8.tflite',
      modelVersion: 'yolov8',
      quantization: false,
      numThreads: 1,
      useGpu: false,
    );

    if (_cameraController != null) {
      _cameraController!.startImageStream((CameraImage image) async {
        if (!isDetecting) {
          isDetecting = true;
          final result = await vision.yoloOnFrame(
            bytesList: image.planes.map((plane) => plane.bytes).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            iouThreshold: 0.5,
            confThreshold: 0.5,
            classThreshold: 0.5,
          );

          isDetecting = false;
          if (result.isNotEmpty) {
            print(result);
            _detectedObjectsProvider.updateDetectedObjects(result);
          }
        }
      });
    }
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

  SendDetails sendDeteils = SendDetails();
  location_uploader() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      // This callback function will run every 2 seconds
      print('Timer fired at ${DateTime.now()}');
      _detectedObjectsProvider.detectedObjects.isNotEmpty &&
              _detectedObjectsProvider.detectedObjects[0]['tag'] == 'pothole'
          ? sendDeteils.sendDetails(context,
              LatLng(_locationData!.latitude!, _locationData!.longitude!))
          : print('no pothole');
      // _detectedObjectsProvider.detectedObjects[0]['tag'] == 'pothole'
      //     ? sendDeteils.sendDetails(context,
      //         LatLng(_locationData!.latitude!, _locationData!.longitude!))
      //     : print('no pothole');
      _detectedObjectsProvider.detectedObjects.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade900,
        onPressed: () {
          location_uploader();
        },
        child: const Icon(Icons.upload),
      ),
      body: ChangeNotifierProvider(
        create: (_) => _detectedObjectsProvider,
        child: SlidingUpPanel(
          color: const Color.fromARGB(255, 0, 0, 0),
          minHeight: 250,
          maxHeight: 700,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          panel: Center(
            child: Consumer<DetectedObjectsProvider>(
              builder: (context, provider, _) {
                if (provider.detectedObjects.isEmpty) {
                  return const Text('No objects detected.');
                } else {
                  return ListView.builder(
                    itemCount: provider.detectedObjects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                '${provider.detectedObjects[index]['tag']}' ==
                                        'pothole'
                                    ? Colors.red
                                    : Colors.purple.shade900,
                          ),
                          child: ListTile(
                            leading: Text(
                              'Lat: ${_locationData!.latitude?.toString()}\nLong: ${_locationData!.longitude?.toString()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            selectedColor: Colors.black,
                            trailing: Text(
                              'Conf: ${double.parse(provider.detectedObjects[index]['box'][4].toStringAsFixed(3))}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            tileColor: Colors.black12,
                            title: Center(
                              child: Text(
                                '${provider.detectedObjects[index]['tag']} detected'
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Add your UI to display detected objects here
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          body: Stack(
            children: [
              CameraPreview(_cameraController!),
              Consumer<DetectedObjectsProvider>(
                  builder: (context, provider, _) {
                //print(provider._detectedObjects);
                if (provider.detectedObjects.isNotEmpty) {
                  return CustomPaint(
                    size: Size(
                      _cameraController!.value.previewSize!.height,
                      _cameraController!.value.previewSize!.width,
                    ),
                    painter: BoundingBoxPainter(
                        provider.detectedObjects,
                        Size(
                          _cameraController!.value.previewSize!.width
                              .toDouble(),
                          _cameraController!.value.previewSize!.height
                              .toDouble(),
                        )),
                  );
                }
                return const SizedBox.shrink();
              })
            ],
          ),
        ),
      ),
    );
  }
}
