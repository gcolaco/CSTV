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
    private let matchDetail: Matches!
    private var firstTeamPlayers: [Player] = []
    private var secondTeamPlayers: [Player] = []
    
    let screenTitle: UILabel = {
        let label = UILabel(frame: .zero)
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
//        getFirstTeamPlayers()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTeamsPlayers(with: matchDetail.opponents)
        
    }
    
    init(matchDetail: Matches) {
        self.matchDetail = matchDetail
        super.init(nibName: nil, bundle: nil)
        
        if matchDetail.status == "running" {
            dateTitle.text = "AGORA"
        } else {
            dateTitle.text = matchDetail.beginAt?.convertStringToDayHourFormat()
        }
        
        screenTitle.text = matchDetail.league.name + " " + (matchDetail.serie.name ?? "")
        opposingTeamView.configureFields(with: matchDetail)
//        getTeamsPlayers(with: matchDetail.opponents)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func getTeamsPlayers(with opponentSlug: [Opponent]) {
        
        opponentSlug.enumerated().forEach { index, team in
            if index == 0 {
                showLoadingView()
                NetworkManager.shared.getPlayersInfo(for: team.opponent.slug) { [weak self] result in
                    guard let self = self else { return }
                    self.dismissLoadingView()
                    switch result {
                    case .success(let team):
                        self.firstTeamPlayers.append(contentsOf: team[index].players)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print("ERROR: \(error.rawValue)")
                    }
                }

            }
            else if index == 1 {
                NetworkManager.shared.getPlayersInfo(for: team.opponent.slug) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let team):
                        self.secondTeamPlayers.append(contentsOf: team[index-1].players)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    case .failure(let error):
                        print("ERROR: \(error.rawValue)")
                    }
                }
            }
        }
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
        tableView.separatorStyle = .none
        
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
        return firstTeamPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TeamLineUpCell.teamLineUpReuseID, for: indexPath) as? TeamLineUpCell {
            cell.selectionStyle = .none
            print("total: \(firstTeamPlayers.count)")
            let firstTeamPlayer = firstTeamPlayers[indexPath.row]
            cell.setFirstTeamSide(with: firstTeamPlayer)
            let secondTeamPlayer = secondTeamPlayers[indexPath.row]
            cell.setSecondTeamSide(with: secondTeamPlayer)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
