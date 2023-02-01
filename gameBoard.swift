import UIKit

class gameBoard: UIViewController {
    
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
    
    @IBOutlet weak var titleLabel: UILabel! //remove this later
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
    
    var currentPlayer: gameBoard.Player? //don't know why
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //start game with p1
        currentPlayer = p1
    }
    
    func game() {
        let winningCondition = checkWinner()
        
        //Decide to stop game or change turns
        if !winningCondition {
            p1.isPlaying = !p1.isPlaying
            p2.isPlaying = !p2.isPlaying
            
            //change turn
            currentPlayer = p1.isPlaying ? p1 : p2
        } else {
            //            titleLabel.text = "Winner is"
            currentPlayer?.isWinner = true
            //show end-game alert msg
            showAlert()
        }
        
        //change current turn label
        currentTurnLabel.text = currentPlayer!.symbol
    }
    
    func checkWinner() -> Bool {
        //winning combinations
        if a1.currentTitle == a2.currentTitle && a2.currentTitle == a3.currentTitle {
            if a1.currentTitle != nil {
                return true
            }
        } else if b1.currentTitle == b2.currentTitle && b2.currentTitle == b3.currentTitle {
            if b1.currentTitle != nil {
                return true
            }
        } else if c1.currentTitle == c2.currentTitle && c2.currentTitle == c3.currentTitle {
            if c1.currentTitle != nil {
                return true
            }
        } else if a1.currentTitle == b1.currentTitle && b1.currentTitle == c1.currentTitle {
            if a1.currentTitle != nil {
                return true
            }
        } else if a2.currentTitle == b2.currentTitle && b2.currentTitle == c2.currentTitle {
            if a2.currentTitle != nil {
                return true
            }
        } else if a3.currentTitle == b3.currentTitle && b3.currentTitle == c3.currentTitle {
            if a3.currentTitle != nil {
                return true
            }
        } else if a1.currentTitle == b2.currentTitle && b2.currentTitle == c3.currentTitle {
            if a1.currentTitle != nil {
                return true
            }
        } else if a3.currentTitle == b2.currentTitle && b2.currentTitle == c1.currentTitle {
            if a3.currentTitle != nil {
                return true
            }
        }
        
        return false
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "\(currentPlayer!.name) won!", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Reset", style: UIAlertAction.Style.default, handler: { _ in
            //Reset Action ->> send back to main screen
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Play again", style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
            //Play again action
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func squarePressed(_ sender: UIButton) {
        if currentPlayer?.isWinner == false { //avoid text change at game end
            //change square text (X/O)
            sender.setTitle(currentPlayer!.symbol, for: .normal)
        }
        
        //main logic
        game()
    }
}
