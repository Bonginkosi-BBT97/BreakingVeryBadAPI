//
//  CharacterTableViewCell.swift
//  BreakingBad
//
//  Created by Nkosi on 2021/02/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nicknameLabel: UILabel!
    @IBOutlet private weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var favouriteBtn: UIButton!
    
    var isFavourited: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupContent(character: CharacterSummary) {
        nameLabel.text = character.name
        nicknameLabel.text = character.nickname
        dateOfBirthLabel.text = character.birthDayDetail
        thumbnailImageView.loadImage(fromURL: character.imageURLString)
        
        
        
    }
    
    //MARK: Favourite button section
    

    @IBAction func favouriteBtnClicked(_ sender: Any) {
        
        
        
        
        
        
        if isFavourited == false {
            
            //favouriteBtn.backgroundColor = .systemFill
            favouriteBtn.tintColor = .red
            
            isFavourited = true
            
        }else {
            
            favouriteBtn.tintColor = .white
            
            isFavourited = false
        }
        
        
        
        
    }
}
