//
//  ViewController.swift
//  CatFactApp-UIKit
//
//  Created by Begüm Arıcı on 20.06.2025.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var newFactButton: UIButton!
    @IBOutlet weak var factLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        factLabel.text = "Loading..."
        fetchNewFact()
        setupUI()
    }


    @IBAction func newFactButtonTapped(_ sender: Any) {
        fetchNewFact()
        
    }
    
    func fetchNewFact() {
        guard let url = URL(string: "https://catfact.ninja/fact")
                else { return }
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data {
                                do {
                                    let catFact = try JSONDecoder().decode(Facts.self, from: data)
                                    print("received fact: \(catFact.fact)")
                                    DispatchQueue.main.async {
                                        self.factLabel.text = "\(catFact.fact)"
                                    }
                                } catch {
                                        print("json parse error: \(error)")
                                }
                        } else if let error = error {
                                    print("network error: \(error)"
                        )}
                    } .resume()
    }
    
    func setupUI() {
        newFactButton.layer.cornerRadius = 15
    }
}

