//
//  Character.swift
//  BreakingBad
//
//  Created by Nkosi on 2021/02/22.
//

import Foundation

protocol CharacterSummary {
    var id: Int { get }
    var name: String { get }
    var nickname: String { get }
    var birthDayDetail : String? { get }
    var imageURLString: String { get }
}

protocol ExtendedCharacterInformation: CharacterSummary {
    var occupationString: String? { get }
    var portrayed: String { get }
    var status: String { get }
    
}

struct Character: Codable, CharacterSummary, ExtendedCharacterInformation {
    var id: Int
    
    var status: String
    
    var occupationString: String? {
        return self.occupation.joined(separator: ",")
    }
    
        
    
    var occupation: [String]
    var portrayed: String
    
    
    let name: String
    let birthday: String
    let imageURLString: String
    let nickname: String
    
    private var birthDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        guard let birthDate = dateFormatter.date(from: self.birthday) else {
            return nil
        }
        
        return birthDate
        
    }
    
    private var age: String {
        
        // Calculating the characters current age from the date of birth
        let calendar = NSCalendar.current
        
        guard let birthDate = self.birthDate else {
            return "0"
        }
        
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        
        guard let ageInYears = ageComponents.year else {
            return "0"
        }
        
        return "\(ageInYears)"
    }
    
    private func birthdayStringInCorrectFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let birthDate = self.birthDate else {
            return nil
        }
        return dateFormatter.string(from: birthDate)
        
    }
    
    var birthDayDetail: String? {
        if birthday.lowercased() == "unknown" {
            return "-"
        }
        
        if let unwrappedBirthDayString = birthdayStringInCorrectFormat() {
            return "\(unwrappedBirthDayString) (\(age))"
        }
        
        return "-"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, birthday, nickname, occupation, portrayed, status
        case id = "char_id"
        case imageURLString = "img"
        
    }
}



/*\
 
 {
     char_id: 1,
     name: "Walter White",
     birthday: "09-07-1958",
     occupation: [
         "High School Chemistry Teacher",
         "Meth King Pin"
     ],
     img: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg",
     status: "Deceased",
     appearance: [1, 2, 3, 4, 5],
     nickname: "Heisenberg",
     portrayed: "Bryan Cranston"
 }
 */
