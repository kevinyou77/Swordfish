//
//  LoginViewController.swift
//  iPortal for Binusmaya
//
//  Created by Kevin Yulias on 28/07/19.
//  Copyright © 2019 Kevin Yulias. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
    
    var courseModels = [CourseModel]()
    var termModels = [TermModel]()
    let loginViewModel = LoginViewModel(dependencies: LoginViewModelDependencies())
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUi()
        self.setupButton()
    }
    
    func setUpUi () {
        loginBtn.layer.cornerRadius = 10
        loginBtn.clipsToBounds = true
    }
    
    func setupButton () {
        _ = self.loginBtn.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                
                let username = self.usernameInput.text ?? ""
                let password = self.passwordInput.text ?? ""
                
                if username == "" || password == "" { self.loginBtn.setTitle("Fill something", for: .normal) }
                
                _ = self.loginViewModel.getAllData(username: username, password: password)
                    .subscribe(
                        onCompleted: {
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "mainViewController", sender: self)
                            }
                        }
                    )
                    .disposed(by: self.disposeBag)
                }
                .disposed(by: self.disposeBag)
    }


}
