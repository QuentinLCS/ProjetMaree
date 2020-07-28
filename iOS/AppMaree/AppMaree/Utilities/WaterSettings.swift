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
 */
func calculHeureSelonTiranDEau(tirantDEau: Double) {
    var days = settingsVM.days!
    let listMarees = getListMarees()
    var mareeNumber = 0
    
    for dayNumber in 0..<days.count {
        
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
        
        for number in 0..<4 {
            
            if actualDay.portes[number].heure.contains("h") {
                mareeMax = listMarees[mareeNumber+1]
                mareeMin = listMarees[mareeNumber]
                mareeNumber += 1
                heureMareeMax = convertStringHourToDouble(heure: mareeMax.heure, separator: ":")
                heureMareeMin = convertStringHourToDouble(heure: mareeMin.heure, separator: ":")
                heurePorte = convertStringHourToDouble(heure: actualDay.portes[number].heure, separator: "h")
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
                    heure -= floor(heure)
                    if floor( heure * 60 ) < 10 { retour += "0"}
                    retour += "\(Int(floor(heure * 60)))"
                    days[dayNumber].portes[number].estimatedHour = retour
                }
            }
        }
    }
    settingsVM.days = days
}

/**
 * Fonction qui converti l'heure en décimal
 *
 * @param heure Heure a convertir
 * @param separator Séparateur entre les heures et les minutes (: ou h)
 * @return Double correspond à l'heure
 */
func convertStringHourToDouble(heure: String, separator: Character) -> Double{
    var heureDouble : Double = Double(heure.split(separator: separator)[0])!
    heureDouble += Double(heure.split(separator: separator)[1])!/60
    return heureDouble
}

func getListMarees() -> [Maree] {
    let days = settingsVM.days!
    var listMarees: [Maree] = []
    
    days.forEach { day in
        day.marees.forEach { maree in
            if !maree.heure.contains("-") {
                listMarees.append(maree)
            }
        }
    }
    
    return listMarees
}
