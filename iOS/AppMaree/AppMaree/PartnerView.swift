//
//  DateView.swift
//  AppMaree
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct PartnerView: View {
    @State private var showAd = false
    @State private var adFile = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let sortedAds: [String: [AdsManager]]
    let sortedCategory: [String]
    
    init() {
        self.sortedAds = mappedAds()
        self.sortedCategory = categoryArray()
    }
    
    var body: some View {
        ZStack {
            if showAd {
                VStack {
                    Image(adFile)
                        .resizable().scaledToFit()
                        .modifier(DraggableModifier(direction: .horizontal, showAd: $showAd))
                    Spacer()
                }
                .zIndex(2)
            }
            ScrollView {
                HStack {
                    TitleView(title: "PORT-DIELETTE", subTitle: "Liste des partenaires")
                }
                Text("L'association des plaisanciers de Port Dielette vous présente la liste de ses partenaires pour l'édition de l'annuaire des marées.")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                ForEach(0..<sortedCategory.count) { category in // create number of rows
                    VStack {
                        Text(self.sortedCategory[category])
                            .font(.title)
                        
                            Spacer()
                                .frame(height: 10)
                        ForEach(0..<self.sortedAds[self.sortedCategory[category]]!.count) { value in
                           
                            Button(action: {
                                self.showAd = true
                                self.adFile = self.sortedAds[self.sortedCategory[category]]![value].file
                            }) { Text(self.sortedAds[self.sortedCategory[category]]![value].name)
                            }
                        }
                        Spacer()
                        .frame(height: 20)
                    }
                }
                Spacer()
                .frame(height: 250)
            }
            ButtonWindowView(presentation: presentationMode)
        }
    }
}

func mappedAds() -> [String: [AdsManager]] {
    let ads: [AdsManager] = getAds()
    //Sort ads by their name and regroup them under the same category
    let map = ads.sorted(by: {$0.name < $1.name }).reduce(into: [String: [AdsManager]]()) { result, element in
        // Get the category of the current element
        let category = element.category
        // initialize an array with one element or add another element to the existing value
        result[category, default: []].append(element)
    }
    return map
}

func categoryArray() -> [String] {
    let ads: [AdsManager] = getAds()
    var array: [String] = []
    //Add in array every existing category
    for ad in ads {
        if !(array.contains(ad.category)) {
            array.append(ad.category)
        }
    }
    //Sort the category by name
    array.sort()
    return array
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        PartnerView()
    }
}
