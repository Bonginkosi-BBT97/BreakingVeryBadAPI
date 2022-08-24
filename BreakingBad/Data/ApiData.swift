//
//
//  BreakingBad
//
//  Created by Nkosi on 2022/07/22.
//

import Foundation

enum URLPathComponents: String {
    case characters = "characters"
    case quotes = "quotes"
}


class ApiData {

    let baseUrl = URL(string: "https://www.breakingbadapi.com/api")!
    var characters: [Character]? = nil
    
    func retrieveCharacters(completion: @escaping () -> ()) {
        let characterURL = baseUrl.appendingPathComponent("characters")
        let urlRequest = URLRequest(url: characterURL)
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
        
            do {
              let jsonDecoder = JSONDecoder()
                guard let results = try? jsonDecoder.decode([Character].self, from: data) else {
                    return
                }
                
            print(results)
                self.characters = results
            }
            
            
            DispatchQueue.main.async {
                completion()
            }
        }.resume()
    }
    
    func retrieveQuotes(for character: CharacterSummary, completion: @escaping ([Quote]) -> ()) {
        let name = character.name.replacingOccurrences(of: " ", with: "+")
        
        let characterURL = baseUrl.appendingPathComponent("quote?author=\(name)")
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.breakingbadapi.com"
        components.path = "/api/quote"
        components.queryItems = [URLQueryItem(name: "author", value: name)]
        
        
        let urlRequest = URLRequest(url: components.url!)
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
        
            let string = String(data: data, encoding: .utf8)
            
            do {
              let jsonDecoder = JSONDecoder()
                
                
                guard let results = try? jsonDecoder.decode([Quote].self, from: data) else {
                    return
                }
                DispatchQueue.main.async {
                    completion(results)
                }
            }
            
            
        }.resume()
    }
}
