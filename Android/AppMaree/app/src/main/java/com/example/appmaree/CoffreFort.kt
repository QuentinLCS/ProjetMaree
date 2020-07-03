package com.example.appmaree

import android.content.Context
import android.content.SharedPreferences

class CoffreFort(context: Context?) {

    private val PREF_NAME: String = "ANNUAIRE_DIELETTE_PREFS"
    private var PRIVATE_MODE = 0
    private var FONTSIZE = "ANNUAIRE_DIELETTE_FONTSIZE"
    private var COLOR = "ANNUAIRE_DIELETTE_COULEUR_FOND"
    private var TIRANTEAU = "ANNUAIRE_DIELETTE_TIRANT_D_EAU"
    private var PUBRESTANT = "ANNUAIRE_DILETTE_PUB_RESTANT"



    val sharedPref: SharedPreferences = context!!.getSharedPreferences(PREF_NAME, PRIVATE_MODE)

    init {
        /*if (sharedPref.getBoolean(PREF_NAME, false)){
            setTirantEau(-1f)
            setFontSize(15)
        }
        else{
            val editor = sharedPref.edit()
            editor.putBoolean(PREF_NAME, true)
            editor.apply()
        }*/
    }

    fun setTirantEau(t: Float){

    }
    fun getTirantEau(): Float{
        return -1f
    }

    fun getFontSize(): Int{
        return 15
    }
    fun setFontSize(s: Int){

    }
    fun setCouleur(s: Int){

    }
    fun getCouleur(): Int{
        return 50
    }
    fun setPubRestant(t: Int){

    }
    fun getPubRestant(): Int{
        return 30
    }


}