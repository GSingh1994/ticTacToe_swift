import UIKit
import SwiftConfettiView
import ViewAnimator

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

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
    
    @IBOutlet weak var gameNumber: UILabel!
    
    //scoreboard
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var playerTwoScore: UILabel!
    @IBOutlet weak var scoreView: UIView!
    
    struct Player {
        var name: String
        var id: String
        var isPlaying: Bool
        var symbol: String
        var score: Int
        var isWinner: Bool
        
        init(name: String, id: String, isPlaying: Bool, symbol: String, score: Int, isWinner: Bool) {
            self.name = name
            self.id = id
            self.isPlaying = isPlaying
            self.symbol = symbol
            self.score = score
            self.isWinner = isWinner
        }
    }
    
    var p1 = Player(name: "p1",id: "p1", isPlaying: false, symbol: "X", score: 0, isWinner: false)
    
    var p2 = Player(name: "p2",id: "p2", isPlaying: false, symbol: "O", score: 0, isWinner: false)
    
    var currentPlayer: gameBoard.Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //hide back-button
        self.navigationItem.setHidesBackButton(true, animated: true)
    
        //show game number
        gameNumber.text = "Game #" + String(p1.score + p2.score + 1)
        
        //add styles to scoreView
        scoreView.layer.cornerRadius = 10
        scoreView.layer.shadowColor = UIColor.gray.cgColor
        scoreView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        scoreView.layer.shadowRadius = 12.0
        scoreView.layer.shadowOpacity = 0.7
        
        //fill labels with player names
        playerOneLabel.text = p1.name
        playerTwoLabel.text = p2.name
        
        //fill previous game scores
        playerOneScore.text = String(p1.score)
        playerTwoScore.text = String(p2.score)
        
        let redColor = UIColor(red: 0.87, green: 0.35, blue: 0.30, alpha: 1.00)
        let greenColor = UIColor(red: 0.34, green: 0.74, blue: 0.68, alpha: 1.00)
        //change player color
        if p1.symbol == "X" {
            playerOneLabel.textColor = redColor
        } else {
            playerOneLabel.textColor = greenColor
        }
        
        if p2.symbol == "X" {
            playerTwoLabel.textColor = redColor
        } else {
            playerTwoLabel.textColor = greenColor
        }

        //start game with p1
        currentPlayer = p1
        p1.isPlaying = true
        
        //add custom gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        let firstGradientColor = UIColor(red: 0.84, green: 0.87, blue: 0.89, alpha: 1.00).cgColor
        let secondGradientColor = UIColor(red: 0.89, green: 0.84, blue: 0.85, alpha: 1.00).cgColor
        gradientLayer.colors = [secondGradientColor,firstGradientColor]
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
            
            //add confetti layer
            let confettiView = SwiftConfettiView(frame: self.view.bounds)
            self.view.addSubview(confettiView)
            confettiView.startConfetti()
            
            //show end-game alert msg
            showAlert(result: "win")
            
            //change scores
            if currentPlayer!.id == "p1" {
                p1.score += 1
            } else if currentPlayer!.id == "p2"{
                p2.score += 1
            }
        }
    }
    
    func resetGame(){
        //clean gameBoard
        totalTurns = 0
        
        //send gameScore to main screen
        let controller = storyboard?.instantiateViewController(withIdentifier: "mainScreen") as! mainScreen
        controller.playerOneScore = p1.score
        controller.playerTwoScore = p2.score
        
        //reloads current view
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view)
    }
    
    func checkWinner() -> Bool {
        //winning combinations
        if a1.restorationIdentifier == a2.restorationIdentifier && a2.restorationIdentifier == a3.restorationIdentifier {
            if a1.restorationIdentifier != nil {
                return true
            }
        }
        if b1.restorationIdentifier == b2.restorationIdentifier && b2.restorationIdentifier == b3.restorationIdentifier {
            if b1.restorationIdentifier != nil {
                return true
            }
        }
        if c1.restorationIdentifier == c2.restorationIdentifier && c2.restorationIdentifier == c3.restorationIdentifier {
            if c1.restorationIdentifier != nil {
                return true
            }
        }
        if a1.restorationIdentifier == b1.restorationIdentifier && b1.restorationIdentifier == c1.restorationIdentifier {
            if a1.restorationIdentifier != nil {
                return true
            }
        }
        if a2.restorationIdentifier == b2.restorationIdentifier && b2.restorationIdentifier == c2.restorationIdentifier {
            if a2.restorationIdentifier != nil {
                return true
            }
        }
        if a3.restorationIdentifier == b3.restorationIdentifier && b3.restorationIdentifier == c3.restorationIdentifier {
            if a3.restorationIdentifier != nil {
                return true
            }
        }
        if a1.restorationIdentifier == b2.restorationIdentifier && b2.restorationIdentifier == c3.restorationIdentifier {
            if a1.restorationIdentifier != nil {
                return true
            }
        }
        if a3.restorationIdentifier == b2.restorationIdentifier && b2.restorationIdentifier == c1.restorationIdentifier {
            if a3.restorationIdentifier != nil {
                return true
            }
        }
        return false
    }
    
    func showAlert(result: String) {
        let alertStatement = result == "win" ? "\(currentPlayer!.name) won!" : "Game Draw!"
        
        let alert = UIAlertController(title: alertStatement, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Go home", style: UIAlertAction.Style.default, handler: { _ in
            //Reset Action ->> send back to main screen
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Play again", style: UIAlertAction.Style.default,handler: {(_: UIAlertAction!) in
            self.resetGame()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func resizeImage(imgName: String) -> UIImage {
        let oimage = UIImage(named: imgName)
        let resizedImage =  oimage?.resized(to: CGSize(width: 80, height: 80))
        return resizedImage!
    }
    
    @IBAction func squarePressed(_ sender: UIButton) {
        //animate button
        let animation = AnimationType.zoom(scale: 0.1)
        sender.imageView!.animate(animations: [animation],duration: 0.1)
        
        // Disable btn after turn
        sender.isEnabled = false
        
        //change square image (X/O)
        let OImage = resizeImage(imgName: "o.svg")
        let XImage = resizeImage(imgName: "x.svg")
        sender.setImage(currentPlayer!.symbol == "X" ? XImage : OImage, for: .normal)
        
        sender.restorationIdentifier = currentPlayer!.symbol //to compare them later
        
        //main logic
        game()
    }
}
