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
    
    
    
    @IBOutlet weak var gameBoardUIView: UIStackView!
    
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
        
        //style Board Ui view
        gameBoardUIView.layer.borderWidth = 5
        gameBoardUIView.layer.borderColor = UIColor.white.cgColor
        gameBoardUIView.layer.shadowColor = UIColor.white.cgColor
        gameBoardUIView.layer.shadowOpacity = 1
        gameBoardUIView.layer.shadowOffset = .zero
        gameBoardUIView.layer.shadowRadius = 10
        gameBoardUIView.layoutMargins = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30);
        
        
        //add custom gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        let firstGradientColor = UIColor(red: 0.84, green: 0.87, blue: 0.89, alpha: 1.00).cgColor
        let secondGradientColor = UIColor(red: 0.89, green: 0.84, blue: 0.85, alpha: 1.00).cgColor
        gradientLayer.colors = [firstGradientColor,secondGradientColor]
        gradientLayer.zPosition = -1
        gradientLayer.opacity = 1
        view.layer.addSublayer(gradientLayer)
    }
    
    //track total turns for draw condition
    var totalTurns: Int = 0
    
    func game() {
        
        totalTurns += 1
        
        let winningCondition = checkWinner()
        
        //Draw game
        if !winningCondition && totalTurns == 9 {
            return showAlert(result: "draw")
        }
            
        //Decide winner or change turns
        if !winningCondition {
            p1.isPlaying = !p1.isPlaying
            p2.isPlaying = !p2.isPlaying
            
            //change turn
            currentPlayer = p1.isPlaying ? p1 : p2
        } else {
            currentPlayer?.isWinner = true
            //show end-game alert msg
            showAlert(result: "win")
        }
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
    
    func showAlert(result: String) {
        var alertStatement = result == "win" ? "\(currentPlayer!.name) won!" : "Draw!!"
        
        let alert = UIAlertController(title: alertStatement, message: nil, preferredStyle: UIAlertController.Style.alert)
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
//        if currentPlayer?.isWinner == false {
            //avoid text change at game end
           
//        }
        
        // Disable btn after turn
        sender.isEnabled = false
        //change square text (X/O)
        sender.setTitle(currentPlayer!.symbol, for: .normal)
        
        // change X and O colors
        if sender.currentTitle == "X" {
            sender.setTitleColor(UIColor(red: 0.60, green: 0.77, blue: 0.95, alpha: 1.00), for: .normal)
        } else {
            sender.setTitleColor(UIColor(red: 0.93, green: 0.48, blue: 0.55, alpha: 1.00), for: .normal)
        }
        
        //main logic
        game()
    }
}
