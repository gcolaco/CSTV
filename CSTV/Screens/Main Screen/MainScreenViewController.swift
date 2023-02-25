//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

final class MainScreenViewController: CSTVDataLoadingViewController {
    //MARK: - Components
    
    private let tableView = UITableView()
    private var allMatches: [Matches] = []
    private var page: Int = 1
    private var hasMoreMatches = true //to stop pagination when api is returning less then 10 matches
    private var isLoadingMoreMatches = false


    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupNavigationController()
        view.backgroundColor = CSTVColors.mainBgColor
        getMatches(page: page)
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

        tableView.backgroundColor = .clear
        tableView.rowHeight = 230

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.removeExcessCells()
        
        tableView.register(MatchesCell.self, forCellReuseIdentifier: MatchesCell.matchesCellReuseID)
    }
    
    //MARK: - Fetching data methods
    
    private func getMatches(page: Int) {
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
//                self.presentGFALertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                print("ERROR: \(error.rawValue)")
            }
            self.isLoadingMoreMatches = false
        }
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MatchesCell.matchesCellReuseID, for: indexPath) as? MatchesCell {
            cell.selectionStyle = .none
    //        cell.layoutMargins = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
            let matches = allMatches[indexPath.row]
            cell.set(matches: matches)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchdetailsVC = MatchDetailViewController()
        matchdetailsVC.modalPresentationStyle = .overFullScreen
        self.present(matchdetailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard hasMoreMatches, !isLoadingMoreMatches else {return}
            page += 1
            getMatches(page: page)
            
        }
    }

}
