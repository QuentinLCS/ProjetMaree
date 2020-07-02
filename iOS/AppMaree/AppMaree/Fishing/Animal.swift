//
//  Animal.swift
//  AppMaree
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

struct Animal: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let allowedSize: Int
    let allowedDate: (String, String)
    let allowedPerPerson: Int
    let taggingObligation: Bool
    let description: String
    let helpImage: String?
    
    init(name: String, imageName: String = "fishing", allowedSize: Int, allowedDate: (String, String) = ("",""), allowedPerPerson: Int = 2, taggingObligation: Bool = true, description: String = "", helpImage: String? = nil) {
    
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
        
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent("Poisson.bundle")

        var poissons: [Animal] = []
        
        do {
          let contents = try fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)

          for item in contents {
            let infos = item.lastPathComponent.split(separator: "_")
            let size = infos[1].split(separator: ".")
            poissons.append(Animal(name: String(infos[0]).uppercased(), imageName: item.lastPathComponent, allowedSize: Int(size[0]) ?? 0))
          }
        }
        catch let error as NSError {
          print(error)
        }
        return poissons
    }
    
    static func getShellFishes() -> [Animal] {
        return [
            Animal(name: "BAR", imageName: "bar", allowedSize: 42, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire."),
            Animal(name: "BAR", imageName: "bar", allowedSize: 42, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire."),
            Animal(name: "BAR", imageName: "bar", allowedSize: 42, allowedDate: ("1er Mars", "30 Novembre"), allowedPerPerson: 2, description:  "Réglementation applicable au nord du 48e parallèle d'Audienne à la frontière Belge. Marquage obligatoire.")
        ]
    }
    
    static func countFishes() -> Int {
        return getFishes().count
    }
    
    static func countShellFishes() -> Int {
        return getShellFishes().count
    }
}

