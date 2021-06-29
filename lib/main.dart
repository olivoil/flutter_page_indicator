import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Pages(),
      ),
    );
  }
}

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  final PageController _pageController = PageController(initialPage: 0);
  final double _dotRadius = 10.0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        PageView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          controller: _pageController,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * (.5 / 6)),
                  Container(
                    width: screenSize.width * (4 / 6),
                    height: screenSize.height * (3 / 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage("assets/images/page_01.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * (.25 / 6)),
                  Text(
                    "Page 1",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * (.5 / 6)),
                  Container(
                    width: screenSize.width * (4 / 6),
                    height: screenSize.height * (3 / 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage("assets/images/page_02.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * (.25 / 6)),
                  Text(
                    "Page 2",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * (.5 / 6)),
                  Container(
                    width: screenSize.width * (4 / 6),
                    height: screenSize.height * (3 / 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage("assets/images/page_03.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * (.25 / 6)),
                  Text(
                    "Page 3",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * (.5 / 6)),
                  Container(
                    width: screenSize.width * (4 / 6),
                    height: screenSize.height * (3 / 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage("assets/images/page_04.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: screenSize.height * (.25 / 6)),
                  Text(
                    "Page 4",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: screenSize.height * (5 / 6)),
            AnimatedBuilder(
                animation: _pageController,
                builder: (context, snapshot) {
                  return Container(
                    height: _dotRadius * 2.0,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: PageIndicatorPainter(
                        pageCount: 4,
                        dotRadius: _dotRadius,
                        dotOutlineThickness: _dotRadius / 10,
                        spacing: _dotRadius * 2.5,
                        scrollPosition: _pageController.position,
                        dotFillColor: const Color(0x0F000000),
                        dotOutlineColor: const Color(0x20000000),
                        indicatorColor: const Color(0xFF444444),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ],
    );
  }
}

class PageIndicatorPainter extends CustomPainter {
  PageIndicatorPainter({
    required this.pageCount,
    required this.dotRadius,
    required this.dotOutlineThickness,
    required this.spacing,
    required this.scrollPosition,
    required Color dotFillColor,
    required Color dotOutlineColor,
    required Color indicatorColor,
  })  : dotFillPaint = Paint()..color = dotFillColor,
        dotOutlinePaint = Paint()..color = dotOutlineColor,
        indicatorPaint = Paint()..color = indicatorColor,
        page = scrollPosition.hasPixels && scrollPosition.hasViewportDimension
            ? scrollPosition.pixels / scrollPosition.viewportDimension
            : 0;

  final int pageCount;
  final double dotRadius;
  final double spacing;
  final double page;
  final ScrollPosition scrollPosition;
  final double dotOutlineThickness;
  final Paint dotFillPaint;
  final Paint dotOutlinePaint;
  final Paint indicatorPaint;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double totalWidth =
        (pageCount * (2 * dotRadius)) + ((pageCount - 1) * spacing);

    _drawDots(canvas, center, totalWidth);
    _drawPageIndicator(canvas, center, totalWidth);
  }

  void _drawPageIndicator(Canvas canvas, Offset center, double totalWidth) {
    final double spaceBetweenDotCenters = (2 * dotRadius) + spacing;
    final double pageIndexToLeft = page.floor().toDouble();
    final double leftDotX = (center.dx - (totalWidth / 2)) +
        (pageIndexToLeft * spaceBetweenDotCenters);
    final double transitionPercent = page - pageIndexToLeft;

    final double laggingLeftPositionPercent =
        (transitionPercent - 0.3).clamp(0.0, 1.0) / 0.7;

    final double indicatorLeftX =
        leftDotX + (laggingLeftPositionPercent * spaceBetweenDotCenters);

    final double acceleratedRightPositionPercent =
        (transitionPercent / 0.5).clamp(0.0, 1.0);

    final double indicatorRightX = leftDotX +
        (acceleratedRightPositionPercent * spaceBetweenDotCenters) +
        (2 * dotRadius);

    canvas.drawRRect(
      RRect.fromLTRBR(
        indicatorLeftX,
        center.dy - dotRadius,
        indicatorRightX,
        center.dy + dotRadius,
        Radius.circular(dotRadius),
      ),
      indicatorPaint,
    );
  }

  void _drawDots(Canvas canvas, Offset center, double totalWidth) {
    Offset dotCenter = center.translate((-totalWidth / 2) + dotRadius, 0);

    for (int i = 0; i < pageCount; i++) {
      _drawDot(canvas, dotCenter);
      dotCenter = dotCenter.translate((2 * dotRadius) + spacing, 0);
    }
  }

  void _drawDot(Canvas canvas, Offset dotCenter) {
    canvas.drawCircle(dotCenter, dotRadius - dotOutlineThickness, dotFillPaint);

    Path outlinePath = Path()
      ..addOval(Rect.fromCircle(center: dotCenter, radius: dotRadius))
      ..addOval(Rect.fromCircle(
          center: dotCenter, radius: dotRadius - dotOutlineThickness))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(outlinePath, dotOutlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
