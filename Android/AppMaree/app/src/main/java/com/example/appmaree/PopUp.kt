package com.example.appmaree


import android.os.Handler
import android.view.Gravity.BOTTOM
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.PopupWindow
import androidx.fragment.app.FragmentActivity

import kotlin.collections.ArrayList
import kotlin.random.Random


enum class Categorie(val texte: String) {
    ASSOCIATION("Associations"), RAVITAILLEMENT("Ravitaillement"), BANQUE("Banque"),
    BAR("Bar - Hotellerie - Restauration")
}

class Sponsor (val AdresseImage: Int,val poids: Int,val nom: String,val categorie: Categorie)

class PopUp private constructor(activity: FragmentActivity?) : PopupWindow(activity)  {
    private var image: ImageView?
    private var imageArray: ArrayList<Int>
    private val tempsEntrePub: Long = 45000
    private val handler : Handler
    private val view : View? = activity?.layoutInflater?.inflate(R.layout.activity_popup, null)
    private var pub : Boolean = true
    val arraySponsor : ArrayList<Sponsor>

    companion object {
        private lateinit var instance: PopUp

        fun getInstance(activity: FragmentActivity?): PopUp {
            if(!::instance.isInitialized)  instance = PopUp(activity)
            return instance
        }
    }

    init {
        contentView = view
        handler=Handler()

        setWidth(LinearLayout.LayoutParams.MATCH_PARENT);

        val button = view?.findViewById<Button>(R.id.popupFermer)
        button?.setOnClickListener {
            dismiss()
            if(pub){
                handler.postDelayed({
                    show()
                }, tempsEntrePub)
            }

        }

        image = view?.findViewById<ImageView>(R.id.popupImage)


        arraySponsor= ArrayList()

        arraySponsor.add(Sponsor(R.drawable.atelier_mobile_bateau_2,2,"Atelier Mobile du bateau", Categorie.RAVITAILLEMENT))
        arraySponsor.add(Sponsor(R.drawable.axe_sail_2,3,"Axe Sail", Categorie.BANQUE))
        arraySponsor.add(Sponsor(R.drawable.boulangerie2_1,5,"Boulangerie", Categorie.RAVITAILLEMENT))
        arraySponsor.add(Sponsor(R.drawable.cafe_paix_1,1,"Cafe", Categorie.BAR))

        imageArray = ArrayList()
        for (sponsor in arraySponsor) {
            for (i in 0..sponsor.poids)
                imageArray.add(sponsor.AdresseImage)
        }

        handler.postDelayed({
            show()
        }, tempsEntrePub)

    }


    fun show() {
        image?.setImageResource(imageArray.get(Random.nextInt(imageArray.size)))
        showAtLocation(view, BOTTOM, 0, 0)
        pub = true
    }

    fun showSponsor(resource : Int) {
        image?.setImageResource(resource)
        showAtLocation(view, BOTTOM, 0, 0)
        pub = false
    }

}
/*
        imageArray = intArrayOf(
            R.drawable.appd,
            R.drawable.atelier_mobile_bateau_2,
            R.drawable.axe_sail_2,
            R.drawable.boulangerie2_1,
            R.drawable.bouteille_a_la_mer_2,
            R.drawable.ca,
            R.drawable.cafe_paix_1,
            R.drawable.cambuse_2,
            R.drawable.cap_marine_1,
            R.drawable.carteret_marine_2,
            R.drawable.charles_optique_2,
            R.drawable.cn_dielette_2,
            R.drawable.coccimarket_2,
            R.drawable.comptoir_mer,
            R.drawable.cotentin_surf_club_2,
            R.drawable.ed_and_coif_2,
            R.drawable.hague_hud_plongee_1,
            R.drawable.hague_sud_plongee,
            R.drawable.intermarche_4,
            R.drawable.lagoon_1,
            R.drawable.la_falaise,
            R.drawable.la_falaise_1	,
            R.drawable.les_travailleurs_de_l_amer_2,
            R.drawable.le_bouche_a_oreille_1,
            R.drawable.le_douet,
            R.drawable.le_vent_mer,
            R.drawable.long_john_silver,
            R.drawable.maison_du_biscuit_2,
            R.drawable.manche_iles_express_1,
            R.drawable.mecanautic_1,
            R.drawable.peche_and_co_2,
            R.drawable.peugeot_leroutier,
            R.drawable.sciotot_2,
            R.drawable.snsm,
            R.drawable.taxi_4_,
            R.drawable.taxi_durel_2,
            R.drawable.taxi_thomine_2,
            R.drawable.tcheu_ptit_louis_1,
            R.drawable.ti_pou_bar_1,
            R.drawable.voilerie_des_isles,
            R.drawable.weldom_2)
        */