package com.example.appmaree


import android.view.Gravity.*
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.PopupWindow
import androidx.fragment.app.FragmentActivity
import kotlin.random.Random

class PopUp (var activity: FragmentActivity?) : PopupWindow(activity){
    private var image : ImageView?
    private var imageArray : Array<Int>
    init {
        val view = activity?.layoutInflater?.inflate(R.layout.activity_popup,null)
        contentView=view
        val button = view?.findViewById<Button>(R.id.popupFermer)
        if (button != null) {
            button.setOnClickListener {
                dismiss()
            }
        }
        setWidth(LinearLayout.LayoutParams.MATCH_PARENT);
        image = view?.findViewById<ImageView>(R.id.popupImage)

        imageArray = arrayOf(
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
    }

    fun show() {
        image?.setImageResource(imageArray.get(Random.nextInt(imageArray.size)))
        showAtLocation(activity?.currentFocus, BOTTOM,0,0)
    }

}