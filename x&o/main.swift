//MARK: library
import Foundation


//MARK: gameOver



//MARK: Hello, players!
func hello() {
    print("Welcome to the Tic Tac Toe game!")
}

//MARK: chooseMode

func chooseMode() {
    print("Choose a game mode (or exit)!")
    print("Game modes: one player or two players.")
    print("Enter 1 or 2, or -1(to exit): ", terminator: "")
    while true {
        if let input = readLine(), let players = Int(input) {
            switch players {
            case -1:
                print("Goodbye!")
                exit(0)
            case 1: callMode(players)
            case 2: callMode(players)
            default:
                print("Invalid input!")
                print("Please enter 1, 2, or -1(to exit): ", terminator: "")
            }
        } else {
            print("Invalid input!")
            print("Please enter 1, 2, or -1(to exit): ", terminator: "")
        }
    }
    print("\u{001B}[1J") // clear the screen above the cursor
    print("\u{001B}[H", terminator: "") // move cursor to the beginning
}

//MARK: check
func checkDiagonal(_ t: [[String]]) -> String {
    if t[0][0] == t[1][1], t[1][1] == t[2][2], t[0][0] != "*" {
        return t[0][0]
    }
    if t[0][2] == t[1][1], t[1][1] == t[2][0], t[0][2] != "*" {
        return t[0][2]
    }
    return "-1"
}

func checkRow(_ t: [[String]]) -> String {
    for row in 0..<3 {
        if t[row][0] == t[row][1], t[row][1] == t[row][2], t[row][0] != "*" {
            return t[row][0]
        }
    }
    return "-1"
}

func checkCol(_ t: [[String]]) -> String {
    for col in 0..<3 {
        if t[0][col] == t[1][col], t[1][col] == t[2][col], t[0][col] != "*" {
            return t[0][col]
        }
    }
    return "-1"
}

func checkWinner(_ table: [[String]]) -> String {
    let results = [checkDiagonal(table), checkRow(table), checkCol(table)]
    for result in results {
        if result == "X" || result == "O" {
            return result
        }
    }
    return "-1"
}

//MARK: readCoordinates
func readCoordinates(_ table: [[String]]) -> (row: Int, col: Int)? {
    print("Enter coordinates (two numbers from 1 to 3 separated by a space): ", terminator: "")
    guard let input = readLine() else {
        print("Input error.")
        return nil
    }
    let parts = input.split(separator: " ")
    guard parts.count == 2,
          let row = Int(parts[0]),
          let col = Int(parts[1]),
          (1...3).contains(row),
          (1...3).contains(col) else {
        if let row = Int(parts[0]), (-1...1).contains(row) {
            return (-1, -1)
        }
        print("Invalid input. You must enter two numbers from 1 to 3.")
        return nil
    }
    
    let r = row - 1
    let c = col - 1
    
    if table[r][c] == "X" || table[r][c] == "O" {
        print("This cell is already occupied.")
        return nil
    }
    
    return (row: r, col: c)
}


// MARK: changePlayer
func changePlayer(_ curPlayer: String) -> String {
    return (curPlayer == "X" ? "O" : "X")
}
// MARK: gameForNPlayers
func gameForOnePlayers() {
    print("This mode is under development.\n")
}

func gameForTwoPlayers() -> String? {
    var steps = 0
    var curPlayer = "O"
    var table: [[String]] = [["*", "*", "*"], ["*", "*", "*"], ["*", "*", "*"]]
    
    while steps < 9 {
        curPlayer = changePlayer(curPlayer)
        printTable(table, curPlayer)

        var coords: (row: Int, col: Int)? = nil
        while coords == nil {
            coords = readCoordinates(table)
        }
        if  coords!.row == -1 && coords!.col == -1 {
            return "Game over."
        }
        table[coords!.row][coords!.col] = curPlayer
        steps += 1
        switch checkWinner(table) {
        case "X":
            printTable(table, curPlayer)
            return "Player X wins!"
        case "O":
            printTable(table, curPlayer)
            return "Player O wins!"
        default:
            printTable(table, curPlayer)
        }
    }
    return nil
}


//MARK: callMode
func callMode(_ players: Int) {
    print("\u{001B}[1J") // clear screen above cursor
    print("\u{001B}[H", terminator: "") // move cursor to start
    if players == 1 {
        gameForOnePlayers()
    } else {
        print("Congratulations! \(gameForTwoPlayers() ?? "Friendship win")")
    }
    chooseMode()
}


//MARK: printTable
func printTable(_ table: [[String]], _ curPlayer: String) {
    print("\u{001B}[1J") // clear screen above cursor
    print("\u{001B}[H", terminator: "") // move cursor to start
    print("Mode: Two-player game")
    print("Good luck!")
    print("It's player \(curPlayer) turn:")
    for row in table {
        for el in row {
            print(el, terminator: "")
        }
        print()
    }
}
hello()
chooseMode()
