//
//  XMLParser.swift
//  AppMaree
//
//  Created by unicaen on 02/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct Parser {
    
    func getData() {
        var parser: XMLParser?
        let path = Bundle.main.path(forResource: "data", ofType: "xml")
        if path != nil {
            parser = XMLParser(contentsOf: URL(fileURLWithPath: path!))
        } else {
            NSLog("Failed to find MyFile.xml")
        }

        if parser != nil {
            parser?.parse()
        }

    }
    
    // a few constants that identify what element names we're looking for inside the XML

    let recordKey = "jour"
    let dictionaryKeys = ["EmpName", "EmpPhone", "EmpEmail", "EmpAddress", "EmpAddress1"]

    // a few variables to hold the results as we parse the XML

    var results: [[String: String]]!         // the whole array of dictionaries
    var currentDictionary: [String: String]! // the current dictionary
    var currentValue: String?

    // start element
    //
    // - If we're starting a "record" create the dictionary that will hold the results
    // - If we're starting one of our dictionary keys, initialize `currentValue` (otherwise leave `nil`)

    mutating func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == recordKey {

            self.currentDictionary = [String : String]()

        } else if dictionaryKeys.contains(elementName) {

            self.currentValue = String()

        }

    }

    // found characters
    //
    // - If this is an element we care about, append those characters.
    // - If `currentValue` still `nil`, then do nothing.

    mutating func parser(_ parser: XMLParser, foundCharacters string: String) {

        self.currentValue? += string

    }

    // end element
    //
    // - If we're at the end of the whole dictionary, then save that dictionary in our array
    // - If we're at the end of an element that belongs in the dictionary, then save that value in the dictionary

    mutating func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if elementName == self.recordKey {

            self.results.append(self.currentDictionary)

            self.currentDictionary = nil

        } else if dictionaryKeys.contains(elementName) {

            self.currentDictionary[elementName] = currentValue

            self.currentValue = nil

        }

    }

    // Just in case, if there's an error, report it.

    mutating func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)

        self.currentValue = nil
        self.currentDictionary = nil
        self.results = nil

    }

}
