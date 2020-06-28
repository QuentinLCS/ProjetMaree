//
//  Animal.swift
//  AppMaree
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

struct Animal {
    
    private let name: String
    private let imageName: String
    private let allowedSize: Float
    private let allowedDate: (String, String)
    private let allowedPerPerson: Int
    private let taggingObligation: Bool
    private let description: String
    private let helpImage: String?
    
    init(name: String, imageName: String = "fishing", allowedSize: Float, allowedDate: (String, String), allowedPerPerson: Int, taggingObligation: Bool = true, description: String = "", helpImage: String? = nil) {
    
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
        return "Le/La \(self.name) ne doit pas dépasser une taille de \(self.allowedSize) cm.\n\nAutorisé du \(self.allowedDate.0) au \(self.allowedDate.1), limité à \(self.allowedPerPerson) \(self.name)S par jour et par personne. En dehors de cette période, le pêcher et le relacher est autorisé.\n\n\(self.description)"
    }
    
    static func getFishes() -> [Animal] {
        return [
            Animal(name: "BAR", imageName: "bar", allowedSize: 42.0, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire."),
            Animal(name: "BAR", imageName: "bar", allowedSize: 42.0, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire."),
            Animal(name: "BAR", imageName: "bar", allowedSize: 42.0, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire."),
            Animal(name: "BAR", imageName: "bar", allowedSize: 42.0, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire."),
            Animal(name: "BAR", imageName: "bar", allowedSize: 42.0, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire."),
        ]
    }
    
    static func getShellFishes() -> [Animal] {
        return [
            Animal(name: "BAR", imageName: "bar", allowedSize: 42.0, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire."),
            Animal(name: "BAR", imageName: "bar", allowedSize: 42.0, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire."),
            Animal(name: "BAR", imageName: "bar", allowedSize: 42.0, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire.")
        ]
    }
    
    static func countFishes() -> Int {
        return getFishes().count()
    }
    
    static func countShellFishes() -> Int {
        return getShellFishes().count()
    }
}

