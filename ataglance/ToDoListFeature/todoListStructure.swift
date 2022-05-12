//
//  todoListStructure.swift
//  ataglance
//
//  Created by Luis Alvarado on 4/11/22.
//

import Foundation

//@breif: allows us to save data inputted by the user. 
struct todoItems: Codable {
    var name: String
    var date: Date
    var notes: String
}
