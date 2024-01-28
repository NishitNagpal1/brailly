import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class BrailleCharacterWidget extends StatefulWidget {
  final List<int> braillePattern;

  BrailleCharacterWidget({Key? key, required this.braillePattern})
      : super(key: key);

  @override
  _BrailleCharacterWidgetState createState() => _BrailleCharacterWidgetState();
}

class _BrailleCharacterWidgetState extends State<BrailleCharacterWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // Get the screen size

    return GestureDetector(
      onPanUpdate: (details) {
        // Detect swipe gestures here (if needed)
      },
      child: Center(
        child: Container(
          width: screenSize.width * 0.9, // 80% of screen width
          height: screenSize.height * 0.9, // 80% of screen height
          child: GridView.builder(
            physics:
                NeverScrollableScrollPhysics(), // Disables GridView's scrolling
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing:
                  screenSize.width * 0.1, // 10% of screen width for spacing
              mainAxisSpacing:
                  screenSize.height * 0.1, // 10% of screen height for spacing
            ),
            itemBuilder: (context, index) {
              bool isRaised = widget.braillePattern[index] == 1;
              double dotSize =
                  screenSize.width * 0.3; // Dot size as 30% of screen width

              return GestureDetector(
                onTap: () {
                  if (isRaised) {
                    Vibration.vibrate(duration: 150); // Short vibration
                  }
                },
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isRaised ? Colors.black : Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
