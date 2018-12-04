//
//  HighscoreViewController.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 12/3/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var highscoreTableView: UITableView!
    
    var highscores = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let gameMode = UserDefaultsManager.shared.gameMode {
            titleLabel.text = String(format: NSLocalizedString("highscoreTitle", comment: "View title"), gameMode.rawValue)
        }
        self.highscoreTableView.delegate = self
        self.highscoreTableView.dataSource = self
        self.highscoreTableView.register(UINib(nibName: "HighscoreTableViewCell", bundle: nil), forCellReuseIdentifier: HighscoreTableViewCell.reuseId)
        if let userDefaultScores = UserDefaultsManager.shared.highscore {
            highscores = userDefaultScores
        }
        self.highscoreTableView.reloadData()
        
    }
    
    //MARK: - TableView DataSource protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HighscoreTableViewCell.reuseId
            , for: indexPath) as? HighscoreTableViewCell else {
            fatalError("Cannot dequeue cell with identifier \(HighscoreTableViewCell.reuseId)")
        }
        
        cell.configureCell(index: indexPath.row + 1, score: highscores[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    //MARK: - Methods
    
    @IBAction func backButtonClicked(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
