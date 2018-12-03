//
//  GameViewController.swift
//  Flip'n Win
//
//  Created by Mathieu Lamvohee on 11/26/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MemoryGameDelegate, GameViewProtocol {

    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!{
        didSet {
            startButton.layer.cornerRadius = 5.0
            startButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var blurVisualEffect: UIVisualEffectView!
    @IBOutlet weak var rulesView: UIView!
    @IBOutlet weak var confettiView: UIView!
    @IBOutlet weak var quitButton: UIButton!{
        didSet {
            quitButton.layer.cornerRadius = 5.0
            quitButton.clipsToBounds = true
        }
    }
    
    var presenter: GameViewPresenter!
    
    let gameController = MemoryGame()
    var photosList = [UIImage]()
    var launcher: ConfettiLauncher!
    var gameMode: GameMode = GameMode.Easy
    
    var timer:Timer?
    var seconds: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = false
        
        //Get the pictures from Unsplash Api
        presenter = GameViewPresenter(gameView: self)
        presenter.getPhotos()
        gameMode = presenter.getGameMode()
        
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        
        
        gameController.delegate = self
        resetGame()
        configurePopup(status: PopupStatus.newGame, show: true)
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        configurePopup(status: PopupStatus.newGame, show: false)
        resetGame()
        setupNewGame()
    }
    
    @IBAction func quitButtonClicked(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.resetGame()
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    //MARK: - GameView Delegate
    func refreshData() {
        DispatchQueue.main.async {
            self.cardsCollectionView.reloadData()
            self.cardsCollectionView.contentInset.top = max((self.cardsCollectionView.frame.height - self.cardsCollectionView.contentSize.height) / 2, 0)
            self.startButton.isEnabled = true
        }
    }
    
    // MARK: - Methods
    
    @objc func countdown() {
        seconds -= 1
        timeLabel.text = String(format: "Remaining time: %d", seconds)
        timeLabel.textColor = seconds <= 10 ? .red : UIColor(red: 221/255, green: 147/255, blue: 14/255, alpha: 255/255)
        if seconds == 0 {
            configurePopup(status: PopupStatus.lose, show: true)
        }
    }
    
    func setupNewGame() {
        seconds = presenter.getTimerSeconds()
        let cardsData:[UIImage] = presenter.getPhotoList()
        gameController.newGame(cardsData: cardsData)
    }
    
    func resetGame() {
        gameController.stopGame()
        if timer?.isValid == true {
            timer?.invalidate()
            timer = nil
        }
        cardsCollectionView.isUserInteractionEnabled = false
        cardsCollectionView.reloadData()
        self.cardsCollectionView.contentInset.top = max((self.cardsCollectionView.frame.height - self.cardsCollectionView.contentSize.height) / 2, 0)
        timeLabel.text = String(format: "%@: ---", NSLocalizedString("TIME", comment: "time"))
        startButton.setTitle(NSLocalizedString("Play", comment: "play"), for: .normal)
    }

    //MARK: CollectionView Data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch gameMode {
        case .Easy:
            return gameController.numberOfCards > 0 ? gameController.numberOfCards : 12
        case .Medium:
            return gameController.numberOfCards > 0 ? gameController.numberOfCards : 16
        case .Hard:
            return gameController.numberOfCards > 0 ? gameController.numberOfCards : 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardsCollectionViewCell.reuseId, for: indexPath as IndexPath) as? CardsCollectionViewCell else {
            fatalError("Couldn't dequeue cell with identifier \(CardsCollectionViewCell.reuseId)")
        }
        
        cell.showCard(show: false, animted: false)
        
        guard let card = gameController.cardAtIndex(index: indexPath.item) else { return cell }
        
        cell.card = card
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = collectionView.frame.width / 4.0 - 10.0
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! CardsCollectionViewCell
        
        if cell.shown { return }
        gameController.didSelectCard(card: cell.card)
        
        collectionView.deselectItem(at: indexPath as IndexPath, animated:true)
    }
    
    // MARK: - MemoryGameDelegate
    
    
    func memoryGameDidStart(game: MemoryGame) {
        cardsCollectionView.isUserInteractionEnabled = true
        cardsCollectionView.reloadData()
        self.cardsCollectionView.contentInset.top = max((self.cardsCollectionView.frame.height - self.cardsCollectionView.contentSize.height) / 2, 0)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
    }
    
    func memoryGame(game: MemoryGame, showCards cards: [Card]) {
        for card in cards {
            guard let index = gameController.indexForCard(card: card) else { continue }
            let cell = cardsCollectionView.cellForItem(at: NSIndexPath(item: index, section:0) as IndexPath) as! CardsCollectionViewCell
            cell.showCard(show: true, animted: true)
        }
    }
    
    func memoryGame(game: MemoryGame, hideCards cards: [Card]) {
        for card in cards {
            guard let index = gameController.indexForCard(card: card) else { continue }
            let cell = cardsCollectionView.cellForItem(at: NSIndexPath(item: index, section:0) as IndexPath) as! CardsCollectionViewCell
            cell.showCard(show: false, animted: true)
        }
    }
    
    func memoryGameDidEnd(game: MemoryGame) {
        timer?.invalidate()
        configurePopup(status: PopupStatus.win, show: true)
    }
    
    func configurePopup(status: PopupStatus, show: Bool)  {
        
        if show {
            switch status {
            case .newGame:
                levelLabel.text = String(format:"Level %@", presenter.getGameMode().rawValue)
                ruleLabel.text = String(format:"You have %d seconds to complete this challenge. Good Luck!!! ", presenter.getTimerSeconds())
                startButton.setTitle("Start", for: .normal)
                self.rulesView.isHidden = false
                self.blurVisualEffect.isHidden = false

            case .win:
                levelLabel.text = "Hooray!!!"
                let newScore = presenter.getTimerSeconds() - seconds
                ruleLabel.text = String(format: "Good job you beated the game in %d seconds", newScore)
                
                if let previousScore = UserDefaultsManager.shared.highscore {
                    if  newScore < previousScore {
                        UserDefaultsManager.shared.highscore = newScore
                    }
                } else {
                    UserDefaultsManager.shared.highscore = newScore
                }
                
                
                startButton.setTitle("Restart", for: .normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.rulesView.isHidden = false
                    self.blurVisualEffect.isHidden = false
                    self.confettiView.isHidden = false
                    self.launcher = ConfettiLauncher(layer: self.confettiView)
                    self.launcher.setup(frame: self.confettiView.frame)
                    self.confettiView.layer.addSublayer(self.launcher)
                    self.launcher.launchConfettis()
                }
                
            case .lose:
                levelLabel.text = "Time's Up 😬"
                ruleLabel.text = String(format: "Sorry you have lost. Hit 'Try Again' to give it another try", presenter.getTimerSeconds() - seconds)
                startButton.setTitle("Try Again", for: .normal)
                self.rulesView.isHidden = false
                self.blurVisualEffect.isHidden = false
            

            }
            
        } else {
            self.rulesView.isHidden = true
            self.confettiView.isHidden = true
            self.blurVisualEffect.isHidden = true
        }
    }
    
}
