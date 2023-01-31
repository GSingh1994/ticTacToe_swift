import UIKit

class mainScreen: UIViewController {

    @IBOutlet weak var playerOneName: UITextField!

    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "gameBoard") as! gameBoard
        
        controller.p1.name = playerOneName.text!
        
        show(controller, sender: self)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
