class OnBoardingModel {
  String image;
  String text;
  String title;

  OnBoardingModel({required this.image, required this.text, required this.title});

  static List<OnBoardingModel> list = [
    OnBoardingModel(
      image: 'assets/images/career.png',
      title: 'Your Career',
      text: 'Find your future career with FiWo in easy way and save your time!',
    ),
    OnBoardingModel(
      image: 'assets/images/resume.png',
      title: 'Your Resume',
      text: 'Show everything about you to the employer on our platform!',
    ),
    OnBoardingModel(
      image: 'assets/images/assistant.png',
      title: 'Finding Job Assistant',
      text: 'FiWo help you find employer, apply for a job and tracking process!',
    ),
  ];
}