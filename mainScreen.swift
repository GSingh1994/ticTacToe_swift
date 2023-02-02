import UIKit

class mainScreen: UIViewController {

    @IBOutlet weak var playerOneField: UITextField!
    @IBOutlet weak var playerTwoField: UITextField!
    
    @IBOutlet weak var getPlayerOneChoice: UISegmentedControl!//mayRemove
    @IBOutlet weak var getPlayerTwoChoice: UISegmentedControl!//mayRemove
    
    var p1Symbol: String = "X"
    var p2Symbol: String = "O"
    
    @IBAction func playerOneChoice(_ sender: UISegmentedControl) {
        p1Symbol = sender.selectedSegmentIndex == 0 ? "X" : "O"
//        sender.selectedSegmentIndex = p2Symbol == "O" ? 0 : 1

    }
    
    @IBAction func playerTwoChoice(_ sender: UISegmentedControl) {
        p2Symbol = sender.selectedSegmentIndex == 0 ? "X" : "O"
//        sender.selectedSegmentIndex = p1Symbol == "O" ? 1 : 0
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "gameBoard") as! gameBoard
        
        //send player names to gameBoard view
        controller.p1.name = playerOneField.text!
        controller.p2.name = playerTwoField.text!
        
        controller.p1.score = playerOneScore
        controller.p2.score = playerTwoScore
        
        //send player choice symbol to gameBoard view
        controller.p1.symbol = p1Symbol
        controller.p2.symbol = p2Symbol
        
        show(controller, sender: self)
    }
    
    var playerOneScore = 0
    var playerTwoScore = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}
