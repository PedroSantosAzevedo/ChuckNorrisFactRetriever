//
//  Fact.swift
//  ChuckNorrisFactRetriever
//
//  Created by Pedro Azevedo on 08/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import Foundation


class Fact:Codable{
    //to trace
    let icon_url:String?
    let id:String?
    let url:String?
    
    //real info
    let value:String?
    var category:String! = "Uncategorized"
    
    
    init(categories:String,value:String,icon_url:String,id:String,url:String) {
        self.value = value
        self.icon_url = icon_url
        self.id = id
        self.url = url
        
    }
    
    
}


/*
{"
 categories":[],
 "created_at":"2016-05-01 10:51:41.584544",
 "icon_url":"https://assets.chucknorris.host/img/avatar/chuck-norris.png",
 "id":"gcLofSWNSO-S0j1tU2gtoA",
 "updated_at":"2016-05-01 10:51:41.584544",
 "url":"https://api.chucknorris.io/jokes/gcLofSWNSO-S0j1tU2gtoA",
 "value":"Chuck norris once played golf with tiger woods and beat him! Not i golf though, he just beat tiger over the head mercilessly with his own sand wedge till he surrendered.
 "}


*/

/*
 {"categories":[],"created_at":"2016-05-01 10:51:41.584544","icon_url":"https://assets.chucknorris.host/img/avatar/chuck-norris.png","id":"LPv6QmQoS5iEHhVMzvlI0w","updated_at":"2016-05-01 10:51:41.584544","url":"https://api.chucknorris.io/jokes/LPv6QmQoS5iEHhVMzvlI0w","value":"The Terminator peed his pants when he turned around and saw Chuck Norris behind him."}
 */

