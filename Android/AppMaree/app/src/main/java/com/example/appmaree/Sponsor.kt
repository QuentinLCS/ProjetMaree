package com.example.appmaree

enum class Categorie(val texte: String) {
    ASSOCIATION("Associations"), AVITAILLEMENT("Avitaillement"), BANQUE("Banque"),
    BAR("Bar - Hotellerie - Restauration"),NAUTISME("Nautisme"),PERMIS("Permis Bateau, Croisières, Transport Passagers"),
    CONFORT("Confort"),GARAGE("Garage - Taxi"),BRICOLAGE("Bricolage")
}

data class Sponsor (val AdresseImage: Int,val poids: Int,val nom: String,val categorie: Categorie)

class ListeSponsor {
    val listeSponsor : ArrayList<Sponsor> = ArrayList()

    init{
        listeSponsor.add(Sponsor(R.drawable.atelier_mobile_bateau_2,2,"Atelier Mobile du bateau", Categorie.NAUTISME))
        listeSponsor.add(Sponsor(R.drawable.manche_iles_express_1,1,"Manche Iles Express", Categorie.PERMIS))
        listeSponsor.add(Sponsor(R.drawable.cafe_paix_1,1,"Café de la Paix", Categorie.BAR))
        listeSponsor.add(Sponsor(R.drawable.cotentin_surf_club_2,2,"Club de Surf", Categorie.ASSOCIATION))
        listeSponsor.add(Sponsor(R.drawable.bouteille_a_la_mer_2,2,"Wine shop Une bouteille à la mer", Categorie.AVITAILLEMENT))
        listeSponsor.add(Sponsor(R.drawable.charles_optique_2,2,"Charles  2 Optique", Categorie.CONFORT))
        listeSponsor.add(Sponsor(R.drawable.le_bouche_a_oreille_1,1,"Restaurant Le bouche à oreille", Categorie.BAR))
        listeSponsor.add(Sponsor(R.drawable.les_travailleurs_de_l_amer_2,2,"Brasserie des Pieux Les travailleurs de l'amer ", Categorie.AVITAILLEMENT))
        listeSponsor.add(Sponsor(R.drawable.tcheu_ptit_louis_1,1,"Bar Tcheu ptit Louis", Categorie.BAR))
        listeSponsor.add(Sponsor(R.drawable.appd,1,"Association des plaisanciers Port Dielette", Categorie.ASSOCIATION))
        listeSponsor.add(Sponsor(R.drawable.axe_sail_2,2,"Axe Sail", Categorie.NAUTISME))
        listeSponsor.add(Sponsor(R.drawable.boulangerie2_1,1,"Boulangerie-patisserie Croquez-moi", Categorie.AVITAILLEMENT))
        listeSponsor.add(Sponsor(R.drawable.ca,1,"Crédit Agricole", Categorie.BANQUE))
        listeSponsor.add(Sponsor(R.drawable.cambuse_2,2,"Traiteur La cambuse de Diélette", Categorie.BAR))
        listeSponsor.add(Sponsor(R.drawable.cap_marine_1,1,"Restaurant Le Cap Marine", Categorie.BAR))
        listeSponsor.add(Sponsor(R.drawable.carteret_marine_2,2,"Carteret Marine", Categorie.NAUTISME))
        listeSponsor.add(Sponsor(R.drawable.cn_dielette_2,2,"Centre Nautique de Dielette", Categorie.ASSOCIATION))
        listeSponsor.add(Sponsor(R.drawable.coccimarket_2,2,"Coccimarket", Categorie.AVITAILLEMENT))
        listeSponsor.add(Sponsor(R.drawable.comptoir_mer,1,"Le Comptoir de la Mer", Categorie.NAUTISME))
        listeSponsor.add(Sponsor(R.drawable.ed_and_coif_2,2,"Ed and Coif", Categorie.CONFORT))
        listeSponsor.add(Sponsor(R.drawable.hague_sud_plongee_1,1,"Hague Sud Plongée", Categorie.ASSOCIATION))
        listeSponsor.add(Sponsor(R.drawable.intermarche_4,4,"Intermarché", Categorie.AVITAILLEMENT))
        listeSponsor.add(Sponsor(R.drawable.la_falaise_1,1,"Hotel Restaurant de la Falaise", Categorie.BAR))
        listeSponsor.add(Sponsor(R.drawable.lagoon_1,1,"Institut et Spa le Lagon", Categorie.CONFORT))
        listeSponsor.add(Sponsor(R.drawable.le_douet,1,"Bar Hotel Le Bar du Douet", Categorie.BAR))
        listeSponsor.add(Sponsor(R.drawable.le_vent_mer,1,"Restaurant Brasserie Le Vent de Mer", Categorie.BAR))
        listeSponsor.add(Sponsor(R.drawable.long_john_silver,1,"Long John Silver", Categorie.PERMIS))
        listeSponsor.add(Sponsor(R.drawable.maison_du_biscuit_2,2,"La maison du biscuit", Categorie.AVITAILLEMENT))
        listeSponsor.add(Sponsor(R.drawable.mecanautic_1,1,"MecaNautic", Categorie.NAUTISME))
        listeSponsor.add(Sponsor(R.drawable.peche_and_co_2,2,"Peche and Co", Categorie.NAUTISME))
        listeSponsor.add(Sponsor(R.drawable.peugeot_leroutier,1,"Garage Leroutier", Categorie.GARAGE))
        listeSponsor.add(Sponsor(R.drawable.sciotot_2,2,"Voile et Vent de Sciotot", Categorie.ASSOCIATION))
        listeSponsor.add(Sponsor(R.drawable.snsm,4,"SNSM", Categorie.NAUTISME))
        listeSponsor.add(Sponsor(R.drawable.taxi_durel_2,2,"Taxi Durel", Categorie.GARAGE))
        listeSponsor.add(Sponsor(R.drawable.taxi_thomine_2,2,"Taxi Thomine", Categorie.GARAGE))
        listeSponsor.add(Sponsor(R.drawable.ti_pou_bar_1,1,"Alimentation Pain Ti Pou Bar", Categorie.AVITAILLEMENT))
        listeSponsor.add(Sponsor(R.drawable.voilerie_des_isles,1,"Voilerie des Isles", Categorie.NAUTISME))
        listeSponsor.add(Sponsor(R.drawable.weldom_2,2,"Weldom", Categorie.BRICOLAGE))
    }
}
