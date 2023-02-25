//
//  SceneDelegate.swift
//  CSTV
//
//  Created by Gustavo Colaço on 25/02/23.
//

import UIKit

final class MatchDetailViewController: CSTVDataLoadingViewController {
    
    private let backButton = CSTVBackButton(frame: .zero)
    private let opposingTeamView = OpposingTeamsView()
//    private let lineUpView = TeamsLineUpView()
    private let tableView = UITableView()
    
    let screenTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "League + series"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth   = true
        label.minimumScaleFactor          = 0.9
        label.lineBreakMode               = .byTruncatingTail
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Hoje, 21:00"
        label.textColor = .white
        label.adjustsFontSizeToFitWidth   = true
        label.minimumScaleFactor          = 0.9
        label.lineBreakMode               = .byTruncatingTail
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CSTVColors.mainBgColor
        configureUI()
        configureButtonAction()
        configureTableView()
    }

    
    private func configureUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews(backButton, screenTitle, opposingTeamView, dateTitle, tableView)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            screenTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            screenTitle.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            screenTitle.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 8),
            opposingTeamView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 24),
            opposingTeamView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            opposingTeamView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            dateTitle.topAnchor.constraint(equalTo: opposingTeamView.bottomAnchor, constant: 20),
            dateTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            dateTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            tableView.topAnchor.constraint(equalTo: dateTitle.bottomAnchor, constant: 22),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .clear
        tableView.rowHeight = 100

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.removeExcessCells()
        
        tableView.register(TeamLineUpCell.self, forCellReuseIdentifier: TeamLineUpCell.teamLineUpReuseID)
    }
    
    private func configureButtonAction() {
        backButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }

}

extension MatchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamLineUpCell.teamLineUpReuseID, for: indexPath) as! TeamLineUpCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}
