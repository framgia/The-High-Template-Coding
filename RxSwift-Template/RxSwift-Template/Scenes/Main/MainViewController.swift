//
//  MainViewController.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/6/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

final class MainViewController: UIViewController, BindableType, UITableViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: MainViewModel!
    private let disposeBag = DisposeBag()
    private var repos:[Repo] = []
    private var loadTrigger = PublishSubject<Int>()
    private var page: Int = 1
    
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
        
        let selectTrigger = tableView.rx.itemSelected.compactMap { [weak self] index in
            self?.repos[index.row]
        }.asDriverOnErrorJustComplete()
        
        let input = MainViewModel.Input(trigger: loadTrigger.asDriverOnErrorJustComplete(),
                                        selectRepoTrigger: selectTrigger)
        let output = viewModel.transform(input)
        output.data.drive(dataBinder).disposed(by: disposeBag)
        output.selectedRepo.drive().disposed(by: disposeBag)
        output.isLoading.drive(rx.isLoading).disposed(by: disposeBag)
        output.error.drive(rx.error).disposed(by: disposeBag)
        
        loadTrigger.onNext(1)
    }
}

extension MainViewController {
    var dataBinder: Binder<[Repo]> {
        return Binder(self) {vc, data in
            vc.repos.append(contentsOf: data)
            vc.page += 1
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
        if indexPath.row == repos.count - 1 {
            loadTrigger.onNext(page + 1)
        }
        return cell
    }
}

// MARK: - StoryboardSceneBased
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
