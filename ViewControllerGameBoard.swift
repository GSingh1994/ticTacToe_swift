//
//  ViewControllerGameBoard.swift
//  ticTacToe_swift
//
//  Created by Gagan on 2023-01-31.
//

import UIKit

class ViewControllerGameBoard: UIViewController {
    
    //Board squares
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    @IBOutlet weak var currentTurnLabel: UILabel!
    
    struct Player {
        var name: String
        var isPlaying: Bool
        var symbol: String
        var score: Int
        var isWinner: Bool
        
        init(name: String, isPlaying: Bool, symbol: String, score: Int, isWinner: Bool) {
            self.name = name
            self.isPlaying = isPlaying
            self.symbol = symbol
            self.score = score
            self.isWinner = isWinner
        }
    }
    
    var p1 = Player(name: "p1", isPlaying: true, symbol: "X", score: 0, isWinner: false)
    
    var p2 = Player(name: "p2", isPlaying: false, symbol: "O", score: 0, isWinner: false)
    
    
    var currentPlayer: ViewControllerGameBoard.Player? //don't know why
        
    var winningCondition = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //start game with p1
        currentPlayer = p1
    }
    
    func game() {
        
        //stop game
        if !winningCondition {
            p1.isPlaying = !p1.isPlaying
            p2.isPlaying = !p2.isPlaying
        }
        
        //change turns
        if p1.isPlaying {
            currentPlayer = p1
        } else {
            currentPlayer = p2
        }
        
        //change current turn label
        currentTurnLabel.text = currentPlayer!.symbol
        
    }
    
    @IBAction func squarePressed(_ sender: UIButton) {
        //change square text (X/O)
        sender.setTitle(currentPlayer!.symbol, for: .normal)
        
        
        //main logic
        game()
    }
}
