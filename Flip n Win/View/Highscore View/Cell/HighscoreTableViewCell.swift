//
//  HighscoreTableViewCell.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 12/3/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit

class HighscoreTableViewCell: UITableViewCell {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var containerView: UIView!{
        didSet {
            self.containerView.layer.cornerRadius = 5
            self.containerView.layer.masksToBounds = true
        }
    }
    
    static let reuseId = "ScoreCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(index: Int, score: Int) {
        numberLabel.text = String(format: "%d.", index)
        scoreLabel.text = String(format: "%d points", score)
    }
    
}
