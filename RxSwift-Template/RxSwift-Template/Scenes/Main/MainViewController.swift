//
//  MainViewController.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/6/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

final class MainViewController: UIViewController, BindableType, UITableViewDelegate {
    
    // MARK: - IBOutlets
    

    @IBOutlet private weak var tableView: RefreshTableView!
    
    // MARK: - Properties

    var viewModel: MainViewModel!
    private let disposeBag = DisposeBag()
    private var repos:[Repo] = []
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: RepoCell.self)
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input(trigger: Driver.just(()),
        reloadTrigger: tableView.loadMoreTopTrigger,
        loadMoreTrigger: tableView.loadMoreBottomTrigger)
        
        let output = viewModel.transform(input)
        
        output.data.drive(dataBinder).disposed(by: disposeBag)
        
        output.error
                .drive(rx.error)
                .disposed(by: rx.disposeBag)
            
            output.isLoading
                .drive(rx.isLoading)
                .disposed(by: rx.disposeBag)
            
            output.isReloading
                .drive(tableView.isLoadingMoreTop)
                .disposed(by: rx.disposeBag)
            
            output.isLoadingMore
                .drive(tableView.isLoadingMoreBottom)
                .disposed(by: rx.disposeBag)
    }
}

extension MainViewController {
    var dataBinder: Binder<[Repo]> {
        return Binder(self) {vc, data in
            vc.repos = data
            print(data)
            vc.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RepoCell.self)
        cell.bindViewModel(RepoViewModel(repo: self.repos[indexPath.row]))
        return cell
    }
}

// MARK: - StoryboardSceneBased
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
