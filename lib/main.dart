import 'package:flutter/material.dart';
import 'widgets/playercard.dart';
import 'constants.dart';

void main() => runApp(TicTacToeApp());

class TicTacToeApp extends StatefulWidget {
  const TicTacToeApp({super.key});

  @override
  State<TicTacToeApp> createState() => _TicTacToeAppState();
}

class _TicTacToeAppState extends State<TicTacToeApp> {
  List<String> xorOList = ['', '', '', '', '', '', '', '', ''];
  String theWinner = '';
  bool isOtrun = true;
  bool gameHasResult = false;
  int drawMode = 0;
  int oScore = 0;
  int xScore = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'DotGothic16'),
      home: Scaffold(
        backgroundColor: bodybackground,
        body: getBackground(),
      ),
    );
  }

  Widget getBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: mainBackGround,
        ),
      ),
      child: SafeArea(
        child: getMainBody(),
      ),
    );
  }

  Widget getMainBody() {
    return Column(
      children: [
        getClearButton(),
        SizedBox(height: 20),
        getRowOfPlayerCards(),
        SizedBox(height: 40),
        Expanded(
          child: getGridView(),
        )
      ],
    );
  }

  Widget getClearButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            clearGame();
          },
          icon: Icon(Icons.refresh),
        ),
      ],
    );
  }

  void clearGame() {
    for (int i = 0; i < xorOList.length; i++) {
      xorOList[i] = '';
    }
    gameHasResult = false;
    drawMode = 0;
    setState(() {});
  }

  Widget getRowOfPlayerCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getPlayerTurnCard(
          playerImage: 'black',
          scoretxt: xScore.toString(),
          role: 'x',
          borderColor: !isOtrun ? Colors.amber : Colors.black,
          backGroundColor:
              theWinner == 'x' ? cardWinnerBackground : cardTransparent,
          width: 150.0,
          height: 205.0,
        ),
        getPlayerTurnCard(
          playerImage: 'zemo',
          scoretxt: oScore.toString(),
          role: 'o',
          borderColor: isOtrun ? Colors.amber : Colors.black,
          backGroundColor:
              theWinner == 'o' ? cardWinnerBackground : cardTransparent,
          width: 150.0,
          height: 205.0,
        ),
      ],
    );
  }

  Widget getGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 9,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            tapped(index);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: xorOList[index].isNotEmpty
                  ? Image(
                      image: AssetImage('assets/${xorOList[index]}.png'),
                      width: 50,
                    )
                  : Text(''),
            ),
          ),
        );
      },
    );
  }

  void tapped(index) {
    if (gameHasResult == false) {
      if (isOtrun && xorOList[index].isEmpty) {
        xorOList[index] = 'o';
        isOtrun = false;
        drawMode++;
      }
      if (!isOtrun && xorOList[index].isEmpty) {
        xorOList[index] = 'x';
        isOtrun = true;
        drawMode++;
      }
      if (drawMode == 9) {
        oScore++;
        xScore++;
        print('draw!!!!');
      }
      checkWinner();
    }
    setState(() {});
  }

  void checkWinner() {
    List<List<int>> lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (List<int> line in lines) {
      String player1 = xorOList[line[0]];
      String player2 = xorOList[line[1]];
      String player3 = xorOList[line[2]];
      if (player1 == '' || player2 == '' || player3 == '') {
        continue;
      }
      if (player1 == player2 && player2 == player3) {
        setResult(player1);
        drawMode = 0;
        break;
      }
    }
  }

  void setResult(String winner) {
    gameHasResult = true;
    if (winner == 'x') {
      theWinner = 'x';
      xScore++;
    }
    if (winner == 'o') {
      theWinner = 'o';
      oScore++;
    }
  }
}
