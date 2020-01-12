//
//  API.swift
//  ChuckNorrisFactRetriever
//
//  Created by Pedro Azevedo on 12/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

let api = API()

final class API{
    
    
    func ramdomfetch(urlStr:String,onCompletion:@escaping(Fact)->()){
        
        let urlString = urlStr
        
        guard let url = URL(string: urlString) else {fatalError("Could not retrieve random url")}
        
        let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            guard let data = data else{
                
                fatalError("Could not retrieve data")
            }
            
            guard let fact = try? JSONDecoder().decode(Fact.self, from: data) else {
                fatalError("Failed to decode factd")
            }
            onCompletion(fact)
            
        }
        
        task.resume()
        
    }
    
    func getCategories(onCompletion:@escaping([String])->()){
        
        let urlString = "https://api.chucknorris.io/jokes/categories"
               
               guard let url = URL(string: urlString) else {fatalError("Could not retrieve categories url")}
               
               let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
                   
                   guard let data = data else{
                       
                       fatalError("Could not categories retrieve data")
                   }
                   
                guard let categories = try? JSONDecoder().decode([String].self, from: data) else {
                       fatalError("Failed to decode categories")
                   }
                   onCompletion(categories)
                   
               }
               
               task.resume()
        
        
    }
    
    
    func searchFetch(text:String,onCompletion:@escaping(FactSearch)->()){
          
            let urlString = "https://api.chucknorris.io/jokes/search?query=\(text)"
                      
                      guard let url = URL(string: urlString) else {fatalError("Could not retrieve categories url")}
                      
                      let task = URLSession.shared.dataTask(with: url) { (data, resp, err) in
                          
                          guard let data = data else{
                              
                              fatalError("Could not categories retrieve data")
                          }
                          
                       guard let factList = try? JSONDecoder().decode(FactSearch.self, from: data) else {
                              fatalError("Failed to decode fact from search")
                          }
                          onCompletion(factList)
                          
                      }
                      
                      task.resume()
               
               
          
          
      }
    
    
    
    
}



