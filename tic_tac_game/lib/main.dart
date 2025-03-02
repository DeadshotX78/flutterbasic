import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(9, "");
  String currentPlayer = "X";
  String playerXName = "Player X";
  String playerOName = "Player O";
  int xScore = 0;
  int oScore = 0;
  String gameStatus = "Player X's turn";

  final TextEditingController playerXController = TextEditingController();
  final TextEditingController playerOController = TextEditingController();

  @override
  void dispose() {
    playerOController.dispose();
    playerXController.dispose();
    super.dispose();
  }

  void updatePlayerNames() {
    setState(() {
      playerXName = playerXController.text.isNotEmpty
          ? playerXController.text
          : "Player X";
      playerOName = playerOController.text.isNotEmpty
          ? playerOController.text
          : "Player O";
      gameStatus = "$playerXName's turn";
    });
  }

  void resetBoard() {
    setState(() {
      board = List.filled(9, "");
      gameStatus = "Player X's turn";
      currentPlayer = "X";
    });
  }

  void makeMove(int index) {
    setState(
      () {
        if (board[index] == "") {
          board[index] = currentPlayer;
          if (checkWinner(currentPlayer)) {
            showWinDialog(currentPlayer == "X" ? playerXName : playerOName);
            updateScore();
          } else {
            currentPlayer = currentPlayer == "X" ? "O" : "X";
            gameStatus = currentPlayer == "X"
                ? "$playerXName's turn"
                : "$playerOName's turn";
          }
        }
      },
    );
  }

  void showWinDialog(String winner) {
    showDialog(
      context: context,
      //prevent closing without tapping
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Over!"),
          content: Text("$winner wins!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetBoard();
              },
              child: Text("OK", style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  bool checkWinner(String player) {
    //check rows, columns and diagoanls for a win
    List<List<int>> winningCombinations = [
      //rows
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      //columns
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      //diagonals
      [0, 4, 8],
      [2, 4, 6],
    ];
    return winningCombinations.any((combination) =>
        board[combination[0]] == player &&
        board[combination[1]] == player &&
        board[combination[2]] == player);
  }

  void updateScore() {
    setState(() {
      if (currentPlayer == "X") {
        xScore++;
      } else {
        oScore++;
      }
      resetBoard();
    });
  }

  // void handleTap(int index) {
  //   if (board[index] == "" && winner == "") {
  //     //allow moves only if the game is not over
  //     setState(() {
  //       board[index] = isXTurn ? "X" : "O";
  //       isXTurn = !isXTurn;

  //       checkWinner();
  //     });
  //   }
  // }

  // void checkWinner() {
  //   //define all winning positions
  //   List<List<int>> winPatterns = [
  //     //rows
  //     [0, 1, 2],
  //     [3, 4, 5],
  //     [6, 7, 8],
  //     //columns
  //     [0, 3, 6],
  //     [1, 4, 7],
  //     [2, 5, 8],
  //     //diagonals
  //     [0, 4, 8],
  //     [2, 4, 6],
  //   ];

  //   for (var pattern in winPatterns) {
  //     String first = board[pattern[0]];
  //     if (first != "" &&
  //         first == board[pattern[1]] &&
  //         first == board[pattern[2]]) {
  //       setState(() {
  //         //store wiiner (X or O)
  //         winner = first;
  //         //store winning combination
  //         winningCells = pattern;
  //       });
  //       return;
  //     }
  //   }

  //   //check for draw
  //   //if all cells are filled and no winner
  //   if (!board.contains("") && winner == "") {
  //     setState(() {
  //       winner = "Draw";
  //     });
  //   }
  // }

  // void restartGame() {
  //   setState(() {
  //     board = List.filled(9, "");
  //     isXTurn = true;
  //     winner = "";
  //     winningCells = [];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double gridSize =
                constraints.maxWidth < 500 ? constraints.maxWidth * 0.8 : 300;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //game status
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      gameStatus,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //displaying scores
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "SCOREBOARD : $playerXName [$xScore]  $playerOName [$oScore]",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 5),
                  //game board
                  Container(
                    width: gridSize,
                    height: gridSize,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => makeMove(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                board[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 9,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: playerXController,
                            decoration: InputDecoration(
                              labelText: "Player X",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: playerOController,
                            decoration: InputDecoration(
                              labelText: "Player O",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //player names
                        ElevatedButton(
                          onPressed: updatePlayerNames,
                          child: Text(
                            "Set Names",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                        SizedBox(height: 5),
                        // new game button
                        ElevatedButton(
                          onPressed: resetBoard,
                          child: Text(
                            "New Game",
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
