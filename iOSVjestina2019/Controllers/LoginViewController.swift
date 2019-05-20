import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.errorMessageLabel.isHidden = true
        }
        if let username = usernameTextField.text, let password = passwordTextField.text {
            LoginService().login(username: username, password: password) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.viewControllers.removeLast()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessageLabel.isHidden = false
                    }
                }
            }
        }
    }
}
