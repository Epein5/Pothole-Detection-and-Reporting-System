class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: '''Mount Camera to Vehicle's Front''',
      image: './assets/car_camera.jpg',
      discription: "About 10% of the vehicles today contains a front camera. "
          "Whith the advancement of techonogy and the need for more safety, "
          "This percentage will  increase in the future. "),
  UnbordingContent(
      title: 'Live Detection',
      image: './assets/detect.jpg',
      discription: "Detect potholes and other road defects in real time."
          "Send the data to the cloud to be processed and visualized. "
          "Stored the data in the Firebase DAtabse to be used for future analysis."),
  UnbordingContent(
      title: 'Visualize Data',
      image: './assets/map.png',
      discription:
          "Visualize the data collected from the camera and the sensors in the vehicle. "
          "This will help citizens and governments to make better decisions "
          "and improve the safety of the roads."),
];
