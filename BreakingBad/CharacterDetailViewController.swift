//
//  CharacterDetailViewController.swift
//  BreakingBad
//
//  Created by Nkosi on 2022/07/06.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var portayedByLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var apiData: ApiData?
    
    @IBOutlet weak var quotesStackView: UIStackView!
    var characterDetail: ExtendedCharacterInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        showData()
        
       loadQuotes()
    }
    
    func assign(characterDetail: ExtendedCharacterInformation, apiData: ApiData) {
        
        self.apiData = apiData
        self.characterDetail = characterDetail
    }
    
    func loadQuotes() {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        quotesStackView.addArrangedSubview(activityIndicator)
        
        apiData?.retrieveQuotes(for: characterDetail as! CharacterSummary, completion: { quotes in
            
            DispatchQueue.main.async {
                var alternate = true
                activityIndicator.stopAnimating()
                if quotes.count == 0 {
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.textColor = .darkGray
                    label.text = "None"
                    self.quotesStackView.addArrangedSubview(label)
                }
                for quote in quotes {
                    
                    let label = UILabel()
                    label.translatesAutoresizingMaskIntoConstraints = false
                    label.numberOfLines = 0
                    label.lineBreakMode = .byWordWrapping
                    if alternate {
                        label.backgroundColor = .darkGray
        
                    }
                    alternate = !alternate
                    label.text = quote.quote
                    label.textColor = .white
                    self.quotesStackView.addArrangedSubview(label)
                }
            }
        })
    }
    
    func showData() {
        self.title = characterDetail?.name
        
        if let character = characterDetail {
            imageView.loadImage(fromURL: character.imageURLString)
            nickNameLabel.text = character.nickname
            occupationLabel.text = character.occupationString
            portayedByLabel.text = character.portrayed
            setStatusLabel(status: character.status)
        }
    }

    @IBAction func navigateBackTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func setStatusLabel(status: String) {
        statusLabel.text = status
        let deadwords = ["dead", "deceased"]
        
        let words = ["dead", "deceased", "killed"]
        let combinedResult = words.contains(where: status.lowercased().contains)
        if combinedResult {
            statusLabel.textColor = .white
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
