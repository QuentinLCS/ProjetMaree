//
//  WaterSettings.swift
//  AppMaree
//
//  Created by unicaen on 20/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

let HAUTEUR_PORTE = 1.5
let HAUTEUR_SEUIL_PORTE = 3.5

/**
 * Fonction pour calculer l'horaire d'entrée ou de sortie en fonction du tirant d'eau
 *
 * @param porte Porte (ouverture/fermeture) pour laquelle on veut calculer le nouvelle horaire
 * @param mareeMin Maree avant la porte
 * @param mareeMax Maree après la porte
 * @return Nouvelle horaire calculé
 */
func calculHeureSelonTiranDEau() {
    
    if let tirantDEau = Double(settingsVM.settings.water) {
        let days = settingsVM.days!
        
        for dayNumber in 0..<settingsVM.days!.count {
            
            let nextDay = days[dayNumber+1]
            var actualDay = days[dayNumber]
            var mareeMax: Maree
            var mareeMin: Maree
            var heureMareeMax: Double
            var heureMareeMin: Double
            var heurePorte: Double
            var hauteurMareeMax: Double
            var hauteurMareeMin: Double
            var hauteurMax = 0.0
            var dureeMaree: Double
            var marnage: Double
            var sinus: Double
            var hauteurCalculeePorte: Double
            var hauteurCalculeePlusTirantDEau: Double
            var retour: String
            var heure : Double
            
            for number in 0..<2 {
                
                mareeMax = nextDay.marees[number]
                mareeMin = actualDay.marees[number]
                
                heureMareeMax = Double(nextDay.marees[number].heure.split(separator: "h")[0])!
                heureMareeMin = Double(actualDay.marees[number].heure.split(separator: "h")[0])!
                heurePorte = Double(actualDay.marees[number].heure.split(separator: "h")[0])!
                hauteurMareeMax = Double(mareeMax.hauteur.replacingOccurrences(of: ",", with: "."))!
                hauteurMareeMin = Double(mareeMin.hauteur.replacingOccurrences(of: ",", with: "."))!
                hauteurMax = 0.0
                if heureMareeMin > heureMareeMax { heureMareeMax+=24 }
                if heureMareeMax < heurePorte { heurePorte-=24 }
                if heureMareeMin > heurePorte { heurePorte+=24 }
                dureeMaree = heureMareeMax - heureMareeMin
                marnage = hauteurMareeMax - hauteurMareeMin
                sinus = sin(Double.pi/2 * ((heurePorte-heureMareeMin) / dureeMaree))
                hauteurCalculeePorte = sinus*sinus*marnage+hauteurMareeMin
                hauteurCalculeePlusTirantDEau = hauteurCalculeePorte + tirantDEau - HAUTEUR_PORTE
                if marnage > 0 { hauteurMax = hauteurMareeMax }
                else { hauteurMax = hauteurMareeMin }

                if (hauteurCalculeePlusTirantDEau > hauteurMax) || (hauteurCalculeePlusTirantDEau+0.1 > hauteurMax) {
                    actualDay.portes[number].estimatedHour = "-----"
                } else {
                    heure = dureeMaree / Double.pi * 2.0 * asin(sqrt((hauteurCalculeePlusTirantDEau - hauteurMareeMin) / marnage)) + heureMareeMin
                    if heure > 24 { heure -= 24 }
                    retour = "\(Int(floor(heure)))h"
                    if floor( heure * 60 ) < 10 { retour += "0"}
                    retour += "\(Int(floor(heure * 60)))"
                    actualDay.portes[number].estimatedHour = retour
                }
            }
        }
    }
}
