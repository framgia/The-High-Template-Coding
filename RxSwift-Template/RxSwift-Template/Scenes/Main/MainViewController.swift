//
//  MainViewController.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/6/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

final class MainViewController: UIViewController, BindableType {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties

    var viewModel: MainViewModel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
    }
    
    deinit {
        logDeinit()
    }
    
    // MARK: - Methods
    
    private func configView() {

    }
    
    func bindViewModel() {
        let input = MainViewModel.Input()
        
        _ = viewModel.transform(input)
    }
}

// MARK: - StoryboardSceneBased
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
