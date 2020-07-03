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



    var sharedPref: SharedPreferences = context!!.getSharedPreferences(PREF_NAME, PRIVATE_MODE)

    init {
        val editor: SharedPreferences.Editor
        if (sharedPref.getBoolean(PREF_NAME, false)){
            reset()
        }
        else{
            val editor : SharedPreferences.Editor = sharedPref.edit()
            editor.putBoolean(PREF_NAME, true)
            editor.apply()
        }
    }

    fun setTirantEau(t: Float){
        var editor: SharedPreferences.Editor = sharedPref.edit()
        editor.putFloat(TIRANTEAU, t)
        editor.commit()
    }
    fun getTirantEau(): Float{
        return -1f
    }

    fun setFontSize(s: Float){
        var editor: SharedPreferences.Editor = sharedPref.edit()
        editor.putFloat(FONTSIZE, s)
        editor.commit()
    }
    fun getFontSize(): Float{
        return 15f
    }

    fun setCouleur(s: Float){
        var editor: SharedPreferences.Editor = sharedPref.edit()
        editor.putFloat(COLOR, s)
        editor.commit()
    }
    fun getCouleur(): Int{
        return 50
    }

    fun setPubRestant(t: Float){
        var editor: SharedPreferences.Editor = sharedPref.edit()
        editor.putFloat(PUBRESTANT, t)
        editor.commit()
    }
    fun getPubRestant(): Int{
        return 30
    }

    fun reset(){
        setTirantEau(-1f)
        setFontSize(15f)
        setCouleur(0f)
        setPubRestant(0f)
    }

}