import 'package:flutter/material.dart';
import 'braille_character_widget.dart'; // Your BrailleCharacterWidget file

List<List<int>> textToBraille(String text) {
  Map<String, List<int>> brailleAlphabet = {
    'A': [1, 0, 0, 0, 0, 0],
    'B': [1, 0, 1, 0, 0, 0],
    'C': [1, 1, 0, 0, 0, 0],
    'D': [1, 1, 0, 1, 0, 0],
    'E': [1, 0, 0, 1, 0, 0],
    'F': [1, 1, 1, 0, 0, 0],
    'G': [1, 1, 1, 1, 0, 0],
    'H': [1, 0, 1, 1, 0, 0],
    'I': [0, 1, 1, 0, 0, 0],
    'J': [0, 1, 1, 1, 0, 0],
    'K': [1, 0, 0, 0, 1, 0],
    'L': [1, 0, 1, 0, 1, 0],
    'M': [1, 1, 0, 0, 1, 0],
    'N': [1, 1, 0, 1, 1, 0],
    'O': [1, 0, 0, 1, 1, 0],
    'P': [1, 1, 1, 0, 1, 0],
    'Q': [1, 1, 1, 1, 1, 0],
    'R': [1, 0, 1, 1, 1, 0],
    'S': [0, 1, 1, 0, 1, 0],
    'T': [0, 1, 1, 1, 1, 0],
    'U': [1, 0, 0, 0, 1, 1],
    'V': [1, 0, 1, 0, 1, 1],
    'W': [0, 1, 1, 1, 0, 1],
    'X': [1, 1, 0, 0, 1, 1],
    'Y': [1, 1, 0, 1, 1, 1],
    'Z': [1, 0, 0, 1, 1, 1],
    'a': [1, 0, 0, 0, 0, 0],
    'b': [1, 0, 1, 0, 0, 0],
    'c': [1, 1, 0, 0, 0, 0],
    'd': [1, 1, 0, 1, 0, 0],
    'e': [1, 0, 0, 1, 0, 0],
    'f': [1, 1, 1, 0, 0, 0],
    'g': [1, 1, 1, 1, 0, 0],
    'h': [1, 0, 1, 1, 0, 0],
    'i': [0, 1, 1, 0, 0, 0],
    'j': [0, 1, 1, 1, 0, 0],
    'k': [1, 0, 0, 0, 1, 0],
    'l': [1, 0, 1, 0, 1, 0],
    'm': [1, 1, 0, 0, 1, 0],
    'n': [1, 1, 0, 1, 1, 0],
    'o': [1, 0, 0, 1, 1, 0],
    'p': [1, 1, 1, 0, 1, 0],
    'q': [1, 1, 1, 1, 1, 0],
    'r': [1, 0, 1, 1, 1, 0],
    's': [0, 1, 1, 0, 1, 0],
    't': [0, 1, 1, 1, 1, 0],
    'u': [1, 0, 0, 0, 1, 1],
    'v': [1, 0, 1, 0, 1, 1],
    'w': [0, 1, 1, 1, 0, 1],
    'x': [1, 1, 0, 0, 1, 1],
    'y': [1, 1, 0, 1, 1, 1],
    'z': [1, 0, 0, 1, 1, 1],
    '0': [1, 1, 0, 0, 0, 0],
    '1': [1, 0, 0, 0, 0, 0],
    '2': [1, 0, 1, 0, 0, 0],
    '3': [1, 1, 0, 0, 0, 0],
    '4': [1, 1, 0, 1, 0, 0],
    '5': [1, 0, 0, 1, 0, 0],
    '6': [1, 1, 1, 0, 0, 0],
    '7': [1, 1, 1, 1, 0, 0],
    '8': [1, 0, 1, 1, 0, 0],
    '9': [0, 1, 1, 0, 0, 0],
    '.': [0, 0, 0, 0, 1, 1],
    ',': [0, 0, 1, 0, 0, 0],
    ';': [0, 0, 1, 1, 0, 0],
    ':': [0, 0, 1, 1, 0, 1],
    '?': [0, 0, 1, 0, 1, 1],
    '!': [0, 0, 1, 1, 1, 0],
    "'": [0, 0, 0, 0, 1, 0],
    '"': [0, 0, 0, 0, 1, 1],
    '-': [0, 0, 0, 1, 0, 0],
    '(': [0, 1, 1, 0, 1, 1],
    ')': [1, 1, 0, 1, 0, 1],
    '/': [1, 0, 0, 1, 0, 1],
    '\\': [0, 1, 0, 0, 1, 0],
    '[': [1, 1, 0, 0, 1, 0],
    ']': [0, 1, 0, 0, 0, 1],
    '{': [0, 1, 1, 1, 1, 1],
    '}': [1, 1, 1, 1, 0, 1],
    '<': [1, 1, 0, 0, 1, 1],
    '>': [0, 1, 1, 1, 0, 0],
    '=': [0, 0, 1, 1, 1, 1],
    '*': [1, 0, 1, 1, 0, 1],
  };

  return text
      .toUpperCase()
      .split('')
      .map((char) =>
          brailleAlphabet[char] ??
          [0, 0, 0, 0, 0, 0]) // Fallback pattern for unknown characters
      .toList();
}

// Your BrailleCharacterWidget file

bool isSpacePattern(List<int> pattern) {
  return pattern.every((dot) => dot == 0);
}

class BrailleDisplayScreen extends StatefulWidget {
  final String text;

  BrailleDisplayScreen({Key? key, required this.text}) : super(key: key);

  @override
  _BrailleDisplayScreenState createState() => _BrailleDisplayScreenState();
}

class _BrailleDisplayScreenState extends State<BrailleDisplayScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  late List<List<int>> brailleText;
  late List<String> characters;

  @override
  void initState() {
    super.initState();
    brailleText = textToBraille(widget.text);
    characters = widget.text.split('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Braille Representation'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: brailleText.length,
              onPageChanged: (index) {
                setState(() {
                  // Update the current page index
                  _pageController.jumpToPage(index);
                });
              },
              itemBuilder: (context, index) {
                return BrailleCharacterWidget(
                    braillePattern: brailleText[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: (_pageController.hasClients &&
                      characters.length > _pageController.page!.toInt())
                  ? Text(
                      characters[_pageController.page!.toInt()],
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      characters[0],
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
