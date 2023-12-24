import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MainDeliveryScreen extends StatefulWidget {
  const MainDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<MainDeliveryScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<MainDeliveryScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 114, 63),
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPainter(),
            child: SizedBox(
              height: screenSize.height / 1.4,
              width: screenSize.width,
            ),
          ),
          Positioned(
            top: 130,
            right: 5,
            left: 5,
            child: Lottie.asset(
              tabs[_currentIndex].lottieFile,
              key: Key('${Random().nextInt(999999999)}'),
              width: 600,
              alignment: Alignment.topCenter,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 270,
              child: Column(
                children: [
                  Flexible(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: tabs.length,
                      itemBuilder: (BuildContext context, int index) {
                        OnboardingModel tab = tabs[index];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tab.title,
                              style: const TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 50),
                            Text(
                              tab.subtitle,
                              style: const TextStyle(
                                fontSize: 17.0,
                                color: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int index = 0; index < tabs.length; index++)
                        _DotIndicator(isSelected: index == _currentIndex),
                    ],
                  ),
                  const SizedBox(height: 75)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 170)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 170)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(orangeArc, Paint()..color = Colors.orange);

    Path whiteArc = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height - 185)
      ..quadraticBezierTo(
          size.width / 2, size.height - 70, size.width, size.height - 185)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(whiteArc, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _DotIndicator extends StatelessWidget {
  final bool isSelected;

  const _DotIndicator({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 6.0,
        width: 6.0,
      ),
    );
  }
}

class OnboardingModel {
  final String lottieFile;
  final String title;
  final String subtitle;

  OnboardingModel(this.lottieFile, this.title, this.subtitle);
}

List<OnboardingModel> tabs = [
  OnboardingModel(
    'assets/delivery.json',
    'Xin chào huynhphuocdat2 !',
    'Hãy bắt đầu vận chuyển các đơn hàng nhé,\n khách hàng đang hóng bạn tới lắm ! \n Đến ngay nào hihi... ',
  ),
];
