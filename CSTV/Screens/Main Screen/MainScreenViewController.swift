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
    
//    private let emptyStateView = CSTVEmptyStateView()

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setupNavigationController()
        view.backgroundColor = CSTVColors.mainBgColor
        configureTableView()

//        view.addSubview(emptyStateView)
//        NSLayoutConstraint.activate([
//            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//
//        ])
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

}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchesCell.matchesCellReuseID, for: indexPath) as! MatchesCell
        cell.selectionStyle = .none 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchdetailsVC = MatchDetailViewController()
        matchdetailsVC.modalPresentationStyle = .overFullScreen
        self.present(matchdetailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
