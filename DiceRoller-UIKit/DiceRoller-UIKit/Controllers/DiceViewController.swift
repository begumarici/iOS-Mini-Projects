//
//  ViewController.swift
//  DiceRoller-UIKit
//
//  Created by Begüm Arıcı on 12.07.2025.
//

import UIKit

class DiceViewController: UIViewController {

    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet weak var rollButton: UIButton!
    
    private var rollingTimer: Timer?
    private var finalTimer: Timer?
    private var currentDiceNumber: Int = 1
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diceImageView.image = UIImage(named: "dice1")
        feedbackGenerator.prepare()
        setupUI()
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        startRolling()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        startFinalTimer()
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        startFinalTimer()
    }
    
    @IBAction func rollButtonTapped(_ sender: UIButton) {
        startRolling()
        startFinalTimer()
    }
    
    private func startRolling() {
        rollingTimer?.invalidate()
        finalTimer?.invalidate()
        
        rollingTimer = Timer.scheduledTimer(timeInterval: 0.1,
                                            target: self,
                                            selector: #selector(updateDice),
                                            userInfo: nil,
                                            repeats: true)
        
        feedbackGenerator.prepare()
    }
    
    private func stopRolling() {
        rollingTimer?.invalidate()
        rollingTimer = nil
        
        diceImageView.image = UIImage(named: "dice\(currentDiceNumber)")
    }
    
    private func startFinalTimer() {
        finalTimer?.invalidate()
        finalTimer = Timer.scheduledTimer(withTimeInterval: 2.0,
                                          repeats: false) { [weak self] _ in
            self?.stopRolling()
        }
    }
    
    @objc private func updateDice() {
        currentDiceNumber = Int.random(in: 1...6)
        feedbackGenerator.impactOccurred()
        
        UIView.transition(with: diceImageView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: {
            self.diceImageView.image = UIImage(named: "dice\(self.currentDiceNumber)")
        })
    }
    
    private func setupUI() {
        rollButton.layer.cornerRadius = 15
        let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "Georgia-Bold", size: 20)!,
            ]
        let attributedTitle = NSAttributedString(string: "Roll", attributes: attributes)
            rollButton.setAttributedTitle(attributedTitle, for: .normal)
    }
}
