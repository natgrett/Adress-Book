//
//  AddressCard.swift
//  iOS3-Pidhorodetska-Stoyanova
//
//  Created by Nataliia Pighorodetska on 12.11.19.
//  Copyright © 2019 Nataliia Pighorodetska. All rights reserved.
//

import Foundation


class AddressCard: Codable, Equatable {
    static func == (lhs: AddressCard, rhs: AddressCard) -> Bool {
        return
            
            lhs.name == rhs.name &&
            lhs.surname == rhs.surname &&
            lhs.street == rhs.street

    }
    
    var name: String = ""
    var surname: String = ""
    var street: String = ""
    var index: Int = 0
    var town: String = ""
    var hobbys: [String] = []
    var friends: [AddressCard] = []
    
    init(){
               self.name = ""
               self.surname = ""
               self.street = ""
               self.index = 0
               self.town = ""
               self.hobbys = []
               self.friends = []
    }
    
     init(name:  String, surname: String, street: String, index: Int, town: String, hobbys:  [String], friends: [AddressCard] ) {
        self.name = name
        self.surname = surname
        self.street = street
        self.index = index
        self.town = town
        self.hobbys = hobbys
        self.friends = friends
    }
    
    func add (hobby: String){
        hobbys.append(hobby)
     }
    
    func remove(hobby: String) {
        if let i = hobbys.firstIndex(of: hobby) {
            hobbys.remove(at: i)
        }
    }
    
    func add(friend: AddressCard){
        friends.append(friend)
    }
    
    func remove(friend: AddressCard) {
        if let i = friends.firstIndex(of: friend){
            friends.remove(at: i)
        }
    }
    
}

