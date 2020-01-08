//
//  DAO.swift
//  ChuckNorrisFactRetriever
//
//  Created by Pedro Azevedo on 08/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation

let dao = DAO()
class DAO{
    
    
    let randomUrl = "https://api.chucknorris.io/jokes/random"
    
    //needs to add category after the "="
    let categoryUrl = "https://api.chucknorris.io/jokes/random?category="
    
    var fakeFacts:[Fact] = []
    
    var factSearchs:[Fact] = []

    var categories:[String] = ["uncategorized"]
    
    
    let giantFact = Fact(categories: "fewfew", value: "fwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewdfwfewd", icon_url: "fwfew", id: "fewfew", url: "fgtrtr")
}

