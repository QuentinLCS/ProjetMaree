//
//  Animal.swift
//  AppMaree
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

struct Animal: Identifiable, Decodable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String
    let allowedSize: Int
    let allowedDate: [String]
    let allowedPerPerson: Int
    let taggingObligation: Bool
    let description: String
    let helpImage: String?
    
    static var allAnimals: [[Animal]] = [[]]
    
    init(name: String, imageName: String = "fishing", allowedSize: Int, allowedDate: [String] = ["",""], allowedPerPerson: Int = 2, taggingObligation: Bool = true, description: String = "", helpImage: String? = nil) {
    
        self.name = name
        self.imageName = imageName
        self.allowedSize = allowedSize
        self.allowedDate = allowedDate
        self.allowedPerPerson = allowedPerPerson
        self.taggingObligation = taggingObligation
        self.description = description
        self.helpImage = helpImage
    }
    
    func describe() -> String {
        return "Le/La \(self.name) ne doit pas dépasser une taille de \(self.allowedSize) cm.\n\nAutorisé du \(self.allowedDate[0]) au \(self.allowedDate[1]), limité à \(self.allowedPerPerson) \(self.name)S par jour et par personne. En dehors de cette période, le pêcher et le relacher est autorisé.\n\n\(self.description)\nMarquage " + (self.taggingObligation ? "OBLIGATOIRE" : "FACULTATIF") + "."
    }
    
    static func getFishes() -> [Animal] {
        if allAnimals[0].isEmpty {
            allAnimals = JSONContent.JSONFishesContent()
        }
        return allAnimals[0]
    }
    
    static func getShellFishes() -> [Animal] {
        if allAnimals[0].isEmpty {
            allAnimals = JSONContent.JSONFishesContent()
        }
        return allAnimals[1]
    }

}

