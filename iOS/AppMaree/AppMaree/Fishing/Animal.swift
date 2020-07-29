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
    let allowedSize: Double?
    let allowedDate: [String]?
    let allowedPerPerson: Int?
    let allowedPerShip: Int?
    let taggingObligation: Bool?
    let description: String?
    let helpImage: String?
    
    static var allAnimals: [[Animal]] = [[]]
    
    init(name: String, imageName: String = "logo", allowedSize: Double?, allowedDate: [String]?, allowedPerPerson: Int?, allowedPerShip: Int?, taggingObligation: Bool?, description: String?, helpImage: String?) {
    
        self.name = name
        self.imageName = imageName
        self.allowedSize = allowedSize
        self.allowedDate = allowedDate
        self.allowedPerPerson = allowedPerPerson
        self.allowedPerShip = allowedPerShip
        self.taggingObligation = taggingObligation
        self.description = description
        self.helpImage = helpImage
    }
    
    func describe() -> String {
        var description = ""
        
        if self.allowedSize != nil {
            description += "Le/La \(self.name) ne doit pas dépasser une taille de \(doShortDouble(value: self.allowedSize!, decimals: 1)) cm.\n\n"
        }
        
        if self.allowedDate != nil {
            description += "Autorisé du \(self.allowedDate![0]) au \(self.allowedDate![1]). En dehors de cette période, le pêcher et le relacher est autorisé. "
        }
        
        if self.allowedPerPerson != nil {
            description += "Limité à \(self.allowedPerPerson!) par jour et par personne. "
        }
        
        if self.allowedPerShip != nil {
            description += "Limité à \(self.allowedPerShip!) par navire."
        }
        
        if self.allowedDate != nil || self.allowedPerPerson != nil || self.allowedPerShip != nil {
            description += "\n\n"
        }
        
        if self.description != nil {
            description += "\(self.description!) "
        }
        
        if self.taggingObligation != nil {
            description += "Marquage \(self.taggingObligation! ? "OBLIGATOIRE" : "FACULTATIF")."
        }
        
        if self.description != nil || self.taggingObligation != nil {
            description += "\n\n"
        }
        
        return description
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

