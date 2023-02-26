//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

final class MainScreenViewController: CSTVDataLoadingViewController {
    //MARK: - Components
    
    private let tableView               = UITableView()
    private var allMatches: [Matches]   = []
    private var page: Int               = 1
    private var hasMoreMatches          = true //to stop pagination when api is returning less then 10 matches
    private var isLoadingMoreMatches    = false


    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        view.backgroundColor = CSTVColors.mainBgColor

        getRunningMatches()
        getUpcomingMatches(page: page)
        configureTableView()
    }

    
    //MARK: - Configuration method
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Partidas"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])

        tableView.backgroundColor   = .clear
        tableView.rowHeight         = 230

        tableView.delegate          = self
        tableView.dataSource        = self
        
        tableView.refreshControl    = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        tableView.separatorStyle = .none
        tableView.removeExcessCells()
        
        tableView.register(MatchesCell.self, forCellReuseIdentifier: MatchesCell.matchesCellReuseID)
    }
    
    //MARK: - Fetching data methods
    
    private func getUpcomingMatches(page: Int) {
        showLoadingView()
        isLoadingMoreMatches = true
        
        NetworkManager.shared.getUpcomingMatches(page: page) { [weak self] result in
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let matches):
                if matches.count < 10 { self.hasMoreMatches = false }
                self.allMatches.append(contentsOf: matches)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("ERROR: \(error.rawValue)")
            }
            self.isLoadingMoreMatches = false
        }
    }
    
    private func getRunningMatches() {
        NetworkManager.shared.getRunningMatches { result in
            switch result {
            case .success(let matches):
                self.allMatches.insert(contentsOf: matches, at: 0)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("ERROR: \(error.rawValue)")
            }
        }
    }
    
    @objc private func didPullToRefresh() {
        allMatches.removeAll()
        getUpcomingMatches(page: 1)
        getRunningMatches()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

//MARK: - Extensions - TableView delegate and DataSource

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MatchesCell.matchesCellReuseID, for: indexPath) as? MatchesCell {
            cell.selectionStyle = .none
            let matches         = allMatches[indexPath.row]
            cell.set(matches: matches)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match           = allMatches[indexPath.row]
        let matchdetailsVC  = MatchDetailViewController(matchDetail: match)
        
        matchdetailsVC.modalPresentationStyle = .overFullScreen
        self.present(matchdetailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //This method is responsible for the pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard hasMoreMatches, !isLoadingMoreMatches else {return}
            page += 1
            getUpcomingMatches(page: page)
            
        }
    }

}
