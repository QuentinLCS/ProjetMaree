//
//  XMLParser.swift
//  AppMaree
//
//  Created by unicaen on 02/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct Day: Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    var date: String = ""
    var portes: [Porte] = []
    var marees: [Maree] = []
    var dateShortString: String = ""
    var dateString: String = ""
}

struct Porte: Codable {
    var etat: String
    var heure: String
    var estimatedHour: String?
}

struct Maree: Codable {
    var etat: String
    var heure: String
    var hauteur: String
    var coef: String?
}

class MareeParser: NSObject {
    
    let key = "jour"

    // a few variables to hold the results as we parse the XML

    var results: [Day] = [] // the whole array of days
    var currentDay: Day! // the current day
    var currentValue: String?
    
    
    func getData() {
        var parser: XMLParser?
        let path = Bundle.main.path(forResource: "data", ofType: "xml")
        if path != nil {
            parser = XMLParser(contentsOf: URL(fileURLWithPath: path!))
        } else {
            NSLog("Failed to find MyFile.xml")
        }

        if parser != nil {
            let delegate = self
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

            currentDay = Day()

        } else if elementName == "date" {
            currentDay.name = attributeDict["text"]!
            currentValue = String()

        } else if elementName == "porte" {
            currentDay.portes.append(Porte(etat: attributeDict["etat"]!, heure: attributeDict["heure"]!))
            
        } else if elementName == "maree" {
            currentDay.marees.append(Maree(etat: attributeDict["etat"]!, heure: attributeDict["heure"]!,hauteur: attributeDict["hauteur"]!, coef: attributeDict["coef"]))
        }
    }

    // found characters
    //
    // - If this is an element we care about, append those characters.
    // - If `currentValue` still `nil`, then do nothing.

    func parser(_ parser: XMLParser, foundCharacters string: String) {

        currentValue? += string

    }

    // end element
    //
    // - If we're at the end of the whole dictionary, then save that dictionary in our array
    // - If we're at the end of an element that belongs in the dictionary, then save that value in the dictionary

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if elementName == self.key {

            self.currentDay.marees = sortMaree(marees: self.currentDay.marees)
            results.append(self.currentDay)
            currentDay = nil

        } else if elementName == "date" {

            currentDay.date = currentValue!
            currentDay.dateShortString = dateString(date: currentDay.date, isShort: true)
            currentDay.dateString = dateString(date: currentDay.date)
            currentValue = nil

        }

    }

    // Just in case, if there's an error, report it. (We don't want to fly blind here.)

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)

        self.currentValue = nil
        self.currentDay = nil
        self.results = []

    }
}

func dateString(date: String, isShort: Bool = false) -> String {
    let months: [String]
    
    if isShort {
        months = ["JAN", "FEV", "MAR", "AVR", "MAI", "JUN", "JUI", "AOU", "SEP", "OCT", "NOV", "DEC"]
    } else {
        months = ["JANVIER", "FÉVRIER", "MARS", "AVRIL", "MAI", "JUIN", "JUILLET", "AOÛT", "SEPTEMBRE", "OCTOBRE", "NOVEMBRE", "DÉCEMBRE"]
    }
    
    let dateSplit: [String.SubSequence] = date.split(separator: "/")
    let day: String = String(dateSplit[0])
    let month: String = months[(Int(dateSplit[1]) ?? 0) - 1]
    return day + (isShort ? "\n" : " ") + month
}

func sortMaree(marees: [Maree]) -> [Maree] {
    var marees: [Maree] = marees
    var newArray: [Maree] = []
    
    while newArray.count < 4 {
        var min = 0
        for i in 0 ..< marees.count {
            if (StringHoursComparator(hourString1: marees[i].heure, hourString2: marees[min].heure, separator: ":")) {
                min = i
            }
        }
        newArray.append(marees[min])
        marees.remove(at: min)
    }
    
    return newArray
}

func StringHoursComparator(hourString1: String, hourString2: String, separator: Character) -> Bool {
    let hour1 = hourString1.split(separator: separator)[0]
    let hour2 = hourString2.split(separator: separator)[0]
    
    if hour1 == "" || hour1 == "--" || hour1 == "-------" { return false }
    else if hour2 == "" || hour2 == "--" || hour2 == "-------" { return true }
    else { return Int(hour1)! <= Int(hour2)! }
}

