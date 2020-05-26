//
//  LoginViewController.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/26/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

final class LoginViewController: UIViewController, BindableType, UITableViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var loginBtn: UIButton!
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    // MARK: - Properties
    
    var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {
        title = Title.login
    }
    
    func bindViewModel() {
        let loginTrigger = loginBtn.rx.tap.map { [weak self] _ in
            return (id: self?.idTextField.text, password: self?.passwordTextField.text)
        }
        .asDriverOnErrorJustComplete()
        
        let input = LoginViewModel.Input(loginTrigger: loginTrigger)
        
        let output = viewModel.transform(input)
        
        output.didSelectLogin.drive().disposed(by: disposeBag)
        output.error.drive(rx.error).disposed(by: disposeBag)
    }
}

// MARK: - StoryboardSceneBased
extension LoginViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.login
}
