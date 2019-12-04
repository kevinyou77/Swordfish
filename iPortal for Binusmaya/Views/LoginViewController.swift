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
    
    func assignNewRootController () {
        let appDelegateTemp = UIApplication.shared.delegate as? AppDelegate
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let destinationVc = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        let snapshot:UIView = (appDelegateTemp?.window?.snapshotView(afterScreenUpdates: true))!
        destinationVc.view.addSubview(snapshot);

        appDelegateTemp?.window?.rootViewController = destinationVc
        
        UIView.animate(
            withDuration: 0.3,
            animations: {
                snapshot.layer.opacity = 0;
                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
            },
            completion: { value in
                snapshot.removeFromSuperview();
            }
        );
    }
    
    func setButtonContent () {
        self.loginBtn.setTitle("Loading...", for: .normal)
    }
    
    func setUserDefaults () {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    
    func handleOnAllDataReceived () {
        self.setButtonContent()
        self.setUserDefaults()
        self.assignNewRootController()
    }
    
    func handleLoginButton () {
        let username = self.usernameInput.text ?? ""
        let password = self.passwordInput.text ?? ""
            
        if username == "" || password == "" {
            self.loginBtn.setTitle("Fill something", for: .normal)
        }
            
        self.loginViewModel.getAllData(username: username, password: password) { [weak self] in
            guard let self = self else { return }
            
            self.handleOnAllDataReceived()
        }
    }
    
    func setupButton () {
        self.loginBtn.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            
            self.handleLoginButton()
        }
        .disposed(by: self.disposeBag)
    }


}
