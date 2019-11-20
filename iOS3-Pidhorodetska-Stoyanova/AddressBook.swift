//
//  AddressBook.swift
//  iOS3-Pidhorodetska-Stoyanova
//
//  Created by Nataliia Pighorodetska on 12.11.19.
//  Copyright © 2019 Nataliia Pighorodetska. All rights reserved.
//

import Foundation

class AddressBook: Codable {
    var addressCarts: [AddressCard] = []
    
    func add(card: AddressCard) {
        addressCarts.append(card)
        sort ()
    }
    
    
    func remove(card: AddressCard) {
        if let i = addressCarts.firstIndex(of: card){
            addressCarts.remove(at: i)
        }
        
        for person in addressCarts {
            if let i = person.friends.firstIndex(of: card) {
                person.friends.remove(at: i)
            }
        }
    }
    
    func sort () {
        addressCarts.sort(by: {p1, p2 in return p1.surname < p2.surname})
    }
    
    //suche
    func search (surname:  String) -> AddressCard? {
        for person in addressCarts {
            if surname == person.surname {
                return person
            }
        }
        return nil
    }
//    Archivieren des Adressbuchs in eine Datei
    func save (toFile path: String) {
        let path = "path.plist"
        let url = URL(fileURLWithPath: path)
        
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(self) {
            try? data.write(to: url)
        }
        
    }
//  Erzeugen eines Adressbuchs aus einer Datei
    class func addressBook(fromFile path: String) -> AddressBook? {
        let url = URL(fileURLWithPath: path)
        if let data = try? Data (contentsOf: url) {
            let decoder = PropertyListDecoder()
            if let adressBook = try? decoder.decode(AddressBook.self, from: data) {
                return adressBook
            }
        }
         return nil
    }

}
