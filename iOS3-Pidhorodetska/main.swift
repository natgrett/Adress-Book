//
//  main.swift
//  iOS3-Pidhorodetska-Stoyanova
//
//  Created by Nataliia Pighorodetska on 12.11.19.
//  Copyright © 2019 Nataliia Pighorodetska. All rights reserved.
// Project for university

import Foundation

func autoBookWithCards() -> AddressBook{
    let firstPerson = AddressCard (name: "Albert", surname: "Einstein", street: "Buchauer Str. 9", index: 89073, town: "Ulm", hobbys: ["Geige", "Klavier", "Segeln"], friends: [])
    let secondPerson = AddressCard (name: "Marie", surname: "Curie", street: "Fritschestr. 51", index: 4999, town: "Warschau", hobbys: ["Radiologie", "Buecher"], friends: [])
    let thirdPerson = AddressCard (name: "Jonny", surname: "Depp", street: "Mainstr. 1A", index: 12673, town: "Boston", hobbys: ["Kino", "Box"], friends: [])
    let autoNewBook = AddressBook ()
    autoNewBook.add(card: firstPerson)
    autoNewBook.add(card: secondPerson)
    autoNewBook.add(card: thirdPerson)
    return autoNewBook
}

func read (withPrompt: String) -> String {
    print(withPrompt, terminator: "")
    if let convertedLine = readLine() {
        return convertedLine
    }
    return ""
}

func readInteger (withPrompt: String) -> Int {
    print(withPrompt, terminator: "")
    if let line = readLine()  {
        if let convertedNumber = Int(line){
            return convertedNumber
        }
    }
    return 0
}

func printCard (_ card: AddressCard) {
    print("+-----------------------------------")
    print("| \(card.name) \(card.surname)")
    print("| \(card.street) ")
    print("| \(card.index) ")
    print("| \(card.town) ")
    print("| Hobbys: ")
    for hobby in card.hobbys {
        print("| ", hobby)
    }
    print("| Freunde: ")
    for friend in card.friends {
        print("| ", friend.name, friend.surname, ", ", friend.index, friend.town)
    }
    print("+-----------------------------------")
}




func interfaceFor (addressBook: AddressBook){
    var userChoice1 = ""
    gameLoop: repeat {
        userChoice1 = read (withPrompt: "(E)ingabe, (S)uche, (L)iste oder (Q)uit?")
        switch userChoice1 {
        case "E", "e":
            print ("Neue Karte anlegen:")
            let name = read (withPrompt: "Vorname: ")
            let surname = read (withPrompt: "Nachname: ")
            let street = read (withPrompt: "Straße: ")
            let index = readInteger (withPrompt: "Postleitzahl: ")
            let town = read (withPrompt: "Ort: ")
            var  hobbys: [String] = []
            var hobby = read (withPrompt: "Hobby: (Abbruch mit (Q)) ")
            while hobby != "q" && hobby != "Q" {
                hobby = read (withPrompt: "Hobby: (Abbruch mit (Q)) ")
                hobbys.append(hobby)
            }
            addressBook.add(card: AddressCard(name: name, surname: surname, street: street, index: index, town: town, hobbys: hobbys, friends: []))
            continue gameLoop
        case "L", "l":
            if addressBook.addressCarts.count == 0 {
                print ("Address Buch ist leer")
            }
            for p in addressBook.addressCarts {
                printCard(p)
            }
            continue gameLoop
        case "S", "s":
            let lookingForPerson = read (withPrompt: "Suchname: ")
            if let person = addressBook.search(surname: lookingForPerson) {
                printCard(person)
            } else {
                print ("Es gibt keine person mit Name ", lookingForPerson)
                break
            }
            var userChoice2 = ""
            findingLoop: repeat {
                userChoice2 = read (withPrompt: "(F)reund/in hinzufügen, (L)öschen oder (Z)urück?")
                switch userChoice2 {
                case "F", "f":
                    let nameNewFriend = read (withPrompt: "Name Freund/in: ")
                    if let optionFriend = addressBook.search(surname: nameNewFriend) {
                        if let person = addressBook.search(surname: lookingForPerson) {
                            person.add(friend: optionFriend)
                            print ("`\(nameNewFriend)` hinzugefügt")
                        }
                    } else {
                        print ("Es gibt keine person mit Name ", nameNewFriend)
                    }
                    continue findingLoop
                case "L", "l":
                    addressBook.remove(card: addressBook.search(surname: lookingForPerson) ?? AddressCard ())
                    print ("`\(lookingForPerson)` gelöscht")
                    continue findingLoop
                case "z", "Z":
                    continue gameLoop
                default:
                    continue findingLoop
                }
            } while userChoice2 != "z" && userChoice1 != "Z"
        case "q", "Q":
            break gameLoop
        default:
            continue gameLoop
            
        }
    } while userChoice1 != "q" && userChoice1 != "Q"
}


//Einlesen des Adressbuchs aus einer Datei zum Programmstart. Benutzen Sie als Dateinamen "book.plist"
var myFirstAddressBook = AddressBook()
if let book = AddressBook.addressBook(fromFile: "book.plist")  {
    myFirstAddressBook = book
}

interfaceFor(addressBook: myFirstAddressBook)
myFirstAddressBook.save(toFile: "book.plist")

