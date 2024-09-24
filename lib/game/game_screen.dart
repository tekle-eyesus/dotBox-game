import 'package:dot_box_game/game/about_screen.dart';

import 'package:flutter/material.dart';
import './../components/dot_builder.dart';

class DotsAndBoxesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dots and Boxes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DotsAndBoxesGame(),
    );
  }
}

class DotsAndBoxesGame extends StatefulWidget {
  @override
  _DotsAndBoxesGameState createState() => _DotsAndBoxesGameState();
}

class _DotsAndBoxesGameState extends State<DotsAndBoxesGame> {
  int gridSize = 4; // Default grid size
  bool player1Turn =
      true; // True means Player 1's turn, false means Player 2's turn
  List<List<int>>? horizontalLines;
  List<List<int>>? verticalLines;
  List<List<int>>? boxes;
  int player1Score = 0;
  int player2Score = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    horizontalLines =
        List.generate(gridSize + 1, (_) => List.generate(gridSize, (_) => 0));
    verticalLines =
        List.generate(gridSize, (_) => List.generate(gridSize + 1, (_) => 0));
    boxes = List.generate(gridSize, (_) => List.generate(gridSize, (_) => 0));
    player1Turn = true;
    player1Score = 0;
    player2Score = 0;
  }

  void _resetGame() {
    setState(() {
      _initializeGame();
    });
  }

  void _increaseGridSize() {
    if (gridSize < 5) {
      setState(() {
        gridSize++;
        _initializeGame();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        width: 200,
        duration: Duration(seconds: 1),
        content: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 70),
          height: 44,
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade200,
              borderRadius: BorderRadius.circular(12)),
          child: Text(
            "MAX. GRID SIZE !!",
            style: TextStyle(
                color: Colors.deepPurple.shade600, fontFamily: 'poppins'),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ));
    }
  }

  void _decreaseGridSize() {
    if (gridSize > 2) {
      setState(() {
        gridSize--;
        _initializeGame();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        width: 200,
        duration: Duration(seconds: 1),
        content: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 70),
          height: 44,
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade200,
              borderRadius: BorderRadius.circular(12)),
          child: Text(
            "MIN. GRID SIZE !!",
            style: TextStyle(
                color: Colors.deepPurple.shade600, fontFamily: 'poppins'),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ));
    }
  }

  void _checkForCompletedBoxes() {
    bool boxCompleted = false;
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (boxes![row][col] == 0 &&
            horizontalLines![row][col] != 0 &&
            horizontalLines![row + 1][col] != 0 &&
            verticalLines![row][col] != 0 &&
            verticalLines![row][col + 1] != 0) {
          boxes![row][col] = player1Turn ? 1 : 2;
          boxCompleted = true;
          if (player1Turn) {
            player1Score++;
          } else {
            player2Score++;
          }
        }
      }
    }
    if (!boxCompleted) {
      setState(() {
        player1Turn = !player1Turn;
      });
    }
  }

  void _handleTap(bool isHorizontal, int row, int col) {
    setState(() {
      if (isHorizontal) {
        if (horizontalLines![row][col] == 0) {
          horizontalLines![row][col] = player1Turn ? 1 : 2;
          _checkForCompletedBoxes();
        }
      } else {
        if (verticalLines![row][col] == 0) {
          verticalLines![row][col] = player1Turn ? 1 : 2;
          _checkForCompletedBoxes();
        }
      }

      if (_isGameOver()) {
        _showGameOverDialog();
      }
    });
  }

  bool _isGameOver() {
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (boxes![row][col] == 0) return false;
      }
    }
    return true;
  }

  void _showGameOverDialog() {
    String message;
    if (player1Score > player2Score) {
      message = 'Player 1 Wins!';
    } else if (player2Score > player1Score) {
      message = 'Player 2 Wins!';
    } else {
      message = 'It\'s a Draw!';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          size: 55,
          Icons.person_2_sharp,
          color: (player1Score == player2Score)
              ? Colors.deepPurple.shade900
              : (player1Score > player2Score)
                  ? Colors.blue
                  : Colors.green,
        ),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.deepPurple.shade300,
        title: (player1Score == player2Score)
            ? Text(
                "DRAW",
                style: TextStyle(
                    color: Colors.deepPurple.shade900, fontFamily: 'poppins'),
              )
            : Text(
                "Game Over",
                style: TextStyle(
                    color: Colors.deepPurple.shade900, fontFamily: 'poppins'),
              ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_3,
                  color: Colors.blue,
                  size: 40,
                  weight: 50,
                ),
                Text(
                  player1Score.toString(),
                  style: TextStyle(
                      color: Colors.deepPurple[900],
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.person_3,
                  color: Colors.green,
                  size: 40,
                  weight: 50,
                ),
                Text(
                  player2Score.toString(),
                  style: TextStyle(
                      color: Colors.deepPurple[900],
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )
              ],
            )
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              _resetGame();
            },
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.deepPurple.shade600,
                  border:
                      Border.all(color: Colors.deepPurple.shade400, width: 5),
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                "play Again",
                style: TextStyle(
                    color: Colors.deepPurple.shade300,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _getCurrentPlayerColor() {
    return player1Turn ? Colors.blue : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.deepPurple.shade300,
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.deepPurple.shade300,
            title: Text(
              'DotBox',
              style: TextStyle(
                  color: Colors.deepPurple.shade900,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppins'),
            ),
            actions: [
              PopupMenuButton(
                  iconColor: Colors.deepPurple.shade900,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.deepPurple.shade200,
                  itemBuilder: (context) => [
                        PopupMenuItem(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AboutScreen();
                              }));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.flag,
                                  color: Colors.deepPurple.shade900,
                                ),
                                Text(
                                  "A B O U T",
                                  style: TextStyle(
                                    color: Colors.deepPurple.shade800,
                                    fontFamily: 'poppins',
                                  ),
                                )
                              ],
                            ))
                      ])
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  padding:
                      EdgeInsets.only(right: 20, left: 20, top: 6, bottom: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red.shade400, width: 4),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple.shade600,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_3_rounded,
                        color: _getCurrentPlayerColor(),
                        size: 40,
                      ),
                      Text(
                        "Turn",
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 25,
                            color: Colors.deepPurple.shade200),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.deepPurple.shade500,
                        ),
                        child: Tooltip(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.shade600,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.only(top: 5),
                          message: "Add Grid",
                          child: IconButton(
                            color: Colors.deepPurple.shade900,
                            icon: const Icon(Icons.add),
                            onPressed: _increaseGridSize,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.deepPurple.shade500,
                        ),
                        child: Tooltip(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.shade600,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.only(top: 5),
                          message: "Decrease Grid",
                          child: IconButton(
                            color: Colors.deepPurple.shade900,
                            icon: const Icon(Icons.remove),
                            onPressed: _decreaseGridSize,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.deepPurple.shade500,
                        ),
                        child: Tooltip(
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.deepPurple.shade600,
                          ),
                          message: "Reset",
                          child: IconButton(
                            color: Colors.deepPurple.shade900,
                            icon: Icon(Icons.refresh),
                            onPressed: _resetGame,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade400,
                        borderRadius: BorderRadius.circular(20)),
                    child: Expanded(
                      child: _buildGrid(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 450,
                  padding:
                      EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple.shade300,
                  ),
                  // child: Text(
                  //   'Player1:\t\t\t$player1Score   |   $player2Score \t\t:Player2',
                  //   style: TextStyle(
                  //       fontSize: 24,
                  //       color: Colors.deepPurple.shade100,
                  //       fontFamily: 'poppins'),
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.person_2_rounded,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple.shade900, width: 2),
                              color: Colors.deepPurple.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              player1Score.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.person_2_rounded,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple.shade900, width: 2),
                              color: Colors.deepPurple.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              player2Score.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(gridSize * 2 + 1, (row) {
                return Row(
                  children: List.generate(gridSize * 2 + 1, (col) {
                    if (row % 2 == 0 && col % 2 == 0) {
                      return buildDot();
                    } else if (row % 2 == 0) {
                      return _buildHorizontalLine(row ~/ 2, col ~/ 2);
                    } else if (col % 2 == 0) {
                      return _buildVerticalLine(row ~/ 2, col ~/ 2);
                    } else {
                      return _buildBox(row ~/ 2, col ~/ 2);
                    }
                  }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalLine(int row, int col) {
    return GestureDetector(
      onTap: () => _handleTap(true, row, col),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: horizontalLines![row][col] == 1
              ? Colors.blue
              : horizontalLines![row][col] == 2
                  ? Colors.green
                  : Colors.transparent,
        ),
        width: 48,
        height: 16,
      ),
    );
  }

  Widget _buildVerticalLine(int row, int col) {
    return GestureDetector(
      onTap: () => _handleTap(false, row, col),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: verticalLines![row][col] == 1
              ? Colors.blue
              : verticalLines![row][col] == 2
                  ? Colors.green
                  : Colors.transparent,
        ),
        width: 16,
        height: 48,
      ),
    );
  }

  Widget _buildBox(int row, int col) {
    return Container(
      width: 48,
      height: 48,
      color: boxes![row][col] == 1
          ? Colors.blue.withOpacity(0.5)
          : boxes![row][col] == 2
              ? Colors.green.shade300.withOpacity(0.5)
              : Colors.transparent,
    );
  }
}
