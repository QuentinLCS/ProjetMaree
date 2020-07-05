//
//  XMLParser.swift
//  AppMaree
//
//  Created by unicaen on 02/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct Day {
    var name: String?
    var date: String?
    var portes: [Porte]?
    var marees: [Maree]?
}

struct Porte {
    var etat: String
    var heure: String
}

struct Maree {
    var etat: String
    var heure: String
    var hauteur: String
    var coef: String?
}

class MareeParser: NSObject {
    
    let key = "jour"

    // a few variables to hold the results as we parse the XML

    var results: [Day]! // the whole array of days
    var currentDay: Day! // the current day
    var currentValue: String?
    
    
    class func getData() {
        var parser: XMLParser?
        let path = Bundle.main.path(forResource: "data", ofType: "xml")
        if path != nil {
            parser = XMLParser(contentsOf: URL(fileURLWithPath: path!))
        } else {
            NSLog("Failed to find MyFile.xml")
        }

        if parser != nil {
            let delegate = MareeParser()
            parser?.delegate = delegate
            parser?.parse()
        }
        else {
            print("Unable to parse")
        }
    }
}

extension MareeParser: XMLParserDelegate {
    // start element
    //
    // - If we're starting a "record" create the day that will hold the results
    // - If we're starting one of our day keys, initialize `currentValue` (otherwise leave `nil`)

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == key {

            self.currentDay = Day()

        } else if elementName == "date" {
            self.currentDay.name = attributeDict["text"]!
            self.currentValue = String()

        } else if elementName == "porte" {
            self.currentDay.portes?.append(Porte(etat: attributeDict["etat"]!, heure: attributeDict["heure"]!))
            
        } else if elementName == "maree" {
            self.currentDay.marees?.append(Maree(etat: attributeDict["etat"]!, heure: attributeDict["heure"]!,hauteur: attributeDict["heuteur"]!, coef: attributeDict["coef"]))
        }

    }

    // found characters
    //
    // - If this is an element we care about, append those characters.
    // - If `currentValue` still `nil`, then do nothing.

    func parser(_ parser: XMLParser, foundCharacters string: String) {

        self.currentValue? += string

    }

    // end element
    //
    // - If we're at the end of the whole dictionary, then save that dictionary in our array
    // - If we're at the end of an element that belongs in the dictionary, then save that value in the dictionary

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if elementName == self.key {

            self.results.append(self.currentDay)

            self.currentDay = nil

        } else if elementName == "date" {

            self.currentDay.date = currentValue!

            self.currentValue = nil

        }

    }

    // Just in case, if there's an error, report it. (We don't want to fly blind here.)

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)

        self.currentValue = nil
        self.currentDay = nil
        self.results = nil

    }

}

