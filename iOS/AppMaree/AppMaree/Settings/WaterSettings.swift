//
//  WaterSettings.swift
//  AppMaree
//
//  Created by unicaen on 20/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

let hauteurPorte = 1.5
let hauteurSeuilPorte = 3.5
let settingsVM = SettingsViewModel()

struct NewHours {
    var ouvertureMaree1: String = "--h--"
    var fermetureMaree1: String = "--h--"
    var ouvertureMaree2: String = "--h--"
    var fermetureMaree2: String = "--h--"
}

func affecterCote(tirantEau: Double) -> Double
{
  return (hauteurSeuilPorte + hauteurPorte) + max(tirantEau - hauteurPorte, 0)
}

func tirantEau(tirantEau: Double)
{
    let days = settingsVM.days!
    
    if tirantEau < (hauteurPorte + 0.05) || tirantEau > (hauteurPorte + hauteurSeuilPorte) {
        print("Tirant d'eau invalide")
        return
    }
    
    settingsVM.settings.water = String(tirantEau)
    
    for number in 0 ..< days.count {
        let jourActuel = days[number]
        let jourPrecedent = days[number+1]
        let jourSuivant = days[number-1]
        
        var newHours = NewHours()
        
        if affecterCote(tirantEau: tirantEau) > 0 {
            newHours.ouvertureMaree1 = parametrer(maPorte: jourActuel.porte[0], tirantEau: tirantEau, jourActuel: jourActuel, jourSuivant: jourSuivant, jourPrecedent: jourPrecedent)
            newHours.fermetureMaree1 = parametrer(maPorte: jourActuel.porte[1], tirantEau: tirantEau, jourActuel: jourActuel, jourSuivant: jourSuivant, jourPrecedent: jourPrecedent)
            
            if newHours.ouvertureMaree1=="-----" {  newHours.fermetureMaree1="-----" }
            if newHours.fermetureMaree1=="-----" {  newHours.ouvertureMaree1="-----" }
            
            newHours.ouvertureMaree2 = parametrer(maPorte: jourActuel.porte[2], tirantEau: tirantEau, jourActuel: jourActuel, jourSuivant: jourSuivant, jourPrecedent: jourPrecedent)
            newHours.fermetureMaree2 = parametrer(maPorte: jourActuel.porte[3], tirantEau: tirantEau, jourActuel: jourActuel, jourSuivant: jourSuivant, jourPrecedent: jourPrecedent)
            
            if newHours.ouvertureMaree2=="-----" {  newHours.fermetureMaree2="-----" }
            if newHours.fermetureMaree2=="-----" {  newHours.ouvertureMaree2="-----" }
        }
    }
    
    settingsVM.days = days
}
        

func parametrer(maPorte: Porte, tirantEau: Double, jourActuel: Day, jourSuivant: Day, jourPrecedent: Day)
{
    
    // test des marées de jourPrecedent
    if jourPrecedent.marees[3].heure == 60 {
      if (maPorte.heure >= jourPrecedent.maree[2].heure - 24 && maPorte.heure < jourActuel.maree[0].heure)
      //vérifit si la porte est entre le jourPrécédent et le jourActuel
          return calculTirantEau(tirantEau, maPorte, jourPrecedent.maree[2], jourActuel.maree[0])
    }
    else
    {
      // on est sur la maree 4 du jour précédent
      if (maPorte.heure >= jourPrecedent.maree[3].heure - 24 && maPorte.heure < jourActuel.maree[0].heure)
      //vérifit si la porte est entre le jourPrécédent et le jourActuel
          return calculTirantEau(tirantEau, maPorte, jourPrecedent.maree[3], jourActuel.maree[0])
    }
  
  // test des marées de jourActuel
  if (maPorte.heure >= jourActuel.maree[0].heure && maPorte.heure < jourActuel.maree[1].heure)
    return calculTirantEau(tirantEau, maPorte, jourActuel.maree[0], jourActuel.maree[1])
  if (maPorte.heure >= jourActuel.maree[1].heure && maPorte.heure < jourActuel.maree[2].heure)
    return calculTirantEau(tirantEau, maPorte, jourActuel.maree[1], jourActuel.maree[2])
  if(jourActuel.maree[3].heure != 60) // on est sur un jour à 4 marées
  {
    if (maPorte.heure >= jourActuel.maree[2].heure && maPorte.heure < jourActuel.maree[3].heure)
      return calculTirantEau(tirantEau, maPorte, jourActuel.maree[2], jourActuel.maree[3])
    if (jourSuivant != undefined)
    {
      if (maPorte.heure >= jourActuel.maree[3].heure && maPorte.heure < jourSuivant.maree[0].heure + 24)
        return calculTirantEau(tirantEau, maPorte, jourActuel.maree[3], jourSuivant.maree[0])
    }
  }
  else // on est sur un jour à 3 marées
  {
    if (maPorte.heure >= jourActuel.maree[2].heure && maPorte.heure < jourSuivant.maree[0].heure + 24)
      return calculTirantEau(tirantEau, maPorte, jourActuel.maree[2], jourSuivant.maree[0])
  }
  // test des marées de jourSuivant
  if (jourSuivant != undefined)
  {
    if (maPorte.heure >= jourSuivant.maree[0].heure + 24 && maPorte.heure < jourSuivant.maree[1].heure + 24)
      return calculTirantEau(tirantEau, maPorte, jourSuivant.maree[0], jourSuivant.maree[1])
    if (maPorte.heure >= jourSuivant.maree[1].heure + 24 && maPorte.heure < jourSuivant.maree[2].heure + 24)
      return calculTirantEau(tirantEau, maPorte, jourSuivant.maree[1], jourSuivant.maree[2])
    if (jourSuivant.maree[3].heure != 60)
    {
      if (maPorte.heure >= jourSuivant.maree[2].heure + 24 && maPorte.heure < jourSuivant.maree[3].heure + 24)
        return calculTirantEau(tirantEau, maPorte, jourSuivant.maree[2], jourSuivant.maree[3])
    }
  }
  // si on arrive ici c'est qu'aucune marée ne convient
  return "--1--"
}

function calculTirantEau(tirantEau, porte, mareeMin, mareeMax) // fait le calcul compliqué. Retourne un "String" au format 12h12
{

    if(!porte)
   return "error"
    
    let porteHeure = porte.heure
    
    let aHeure, bHeure
    let aHauteur, bHauteur
    
    aHeure = mareeMin.heure
    aHauteur = mareeMin.hauteur
    
    bHeure = mareeMax.heure
    bHauteur = mareeMax.hauteur
    
    

    // ZZ console.log('################################################### ')
    // ZZ console.log ('aHeure='   + aHeure + '    bHeure='  + bHeure +  '  heure porte=' +porteHeure)
    // ZZ console.log('ahaut : ' + aHauteur + '   bHauteur :'+bHauteur )

    if (aHeure > bHeure)
   bHeure += 24
    // console.log ('aHeure=' +aHeure + '    bHeure='+bHeure + '        ' + '  heure porte=' +porteHeure)
    // Ce cas arrive. il faut le corriger
    //    aHeure=0.4166666666666667    bHeure=6.983333333333333  heure porte=28.05

    //if (aHeure < bHeure && bHeure < 24 && porteHeure >24) {
// porteHeure=porteHeure-24
// console.log('COUCOU')
  //  }

    if (bHeure < porteHeure) { porteHeure=porteHeure-24 }
    if (aHeure > porteHeure) { porteHeure=porteHeure+24 }


    // console.log('aheure : ' + aHeure + '   bheure :'+bHeure )
    // console.log('ahaut : ' + aHauteur + '   bHauteur :'+bHauteur )
    // console.log('HeurePorte officiel : ' + porteHeure  )
    // if (!(aHeure < porteHeure && porteHeure<bHeure))
    // console.log('GROS PROBLEME')



    let cote = affecterCote(tirantEau)
    let dureeMaree = bHeure - aHeure
    let marnage
    let heure
    let hauteurCalculeePlusTirantEau
    let hauteurMax
    
    let heurePorteCalculee
    let hauteurCalculeePorte
    
    // ici tirantEau est une chaine. vive les langages typés !
    tirantEau=parseFloat(tirantEau)
    // le calcul est le meme pour les marées montantes et descendante
    // le principe est le suivant :
    // on calcule la hauteur d'eau ha sur la sinusoide à l'heure de l'ouverture de la porte.
    // a Carteret, on peut avoir jusqu'à 50 cm en plus
    // on ajoute à hauteur d'eau trouvée la différence entre le tirant d'eau et le seuil de la porte et on obtient hauteurplustiranteau
    // on vérifie que hauteurplustiranteau n'est pas supérieur à la hauteur à PM.
    // on calcule l'heure correspondant la hauteurplustiranteau
    
    // on retire la hauteur de la basse mer pour ne travailler que sur la variation de hauteur
    marnage = (bHauteur - aHauteur)
    
    // on calcule la hauteur d'eau à partir de la sinusoide pour l'horaire officiel de la porte
    let sinus=Math.sin(Math.PI/2*((porteHeure-aHeure)/dureeMaree))
    hauteurCalculeePorte =sinus*sinus*marnage+aHauteur

    // on calcule la nouvelle hauteur avec le tirant d'eau
    hauteurCalculeePlusTirantEau=hauteurCalculeePorte+tirantEau-hauteurPorte
    
    //    if (cote > bHauteur || cote < aHauteur)
    
    if (marnage>0) hauteurMax=bHauteur
    else hauteurMax=aHauteur

    if (hauteurCalculeePlusTirantEau > hauteurMax || (hauteurCalculeePlusTirantEau+0.1) > hauteurMax)
   return "-----"

    heure  = dureeMaree / Math.PI * 2.0 * Math.asin(
   Math.sqrt((hauteurCalculeePlusTirantEau-aHauteur) / marnage ))+aHeure
    
  //  if (aHauteur < bHauteur) console.log('#################                        montante  heure='+heure)
  //  else console.log('#################                        descendante heure='+heure)

  //  console.log('aheure : ' + aHeure + '   bheure :'+bHeure + '  dureeMaree : ' + dureeMaree)
  //  console.log('ahaut : ' + aHauteur + '   bHauteur :'+bHauteur + '  marnage : ' + marnage)
  //  console.log('HeurePorte officiel : ' + porteHeure + '    Heure calculee pour tirant eau:' + heure )
  //  console.log('hauteurCalculeePorte   '+hauteurCalculeePorte)
  //  console.log('hauteurCalculeePlusTirantEau : '+hauteurCalculeePlusTirantEau)
  //  console.log('   tiranteau '+ tirantEau +' hauteurPorte '+  hauteurPorte     )

//    if ((marnage > 0 && heure<=porteHeure ) || (marnage < 0 && heure>=porteHeure ))
// console.log('GROS PROBLEME')

    
    //if (heure>porteHeure)  delta = (heure-porteHeure)
    //else delta=porteHeure-heure
    
    if (heure > 24)
   heure -= 24
    
    let minute = Math.floor(heure%1*60)
    
    let retour = Math.floor(heure) + "h" // format : "12h"
    
    if (minute < 10)
   retour = retour + "0" + minute
    else
   retour += minute
    return retour
}


