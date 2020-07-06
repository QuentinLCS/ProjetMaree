package com.example.appmaree

import android.content.Context
import android.content.SharedPreferences
import android.widget.Toast

class CoffreFort(context: Context?) {

    private val PREF_NAME: String = "ANNUAIRE_DIELETTE_PREFS"
    private var PRIVATE_MODE = 0
    private var FONTSIZE = "ANNUAIRE_DIELETTE_FONTSIZE"
    private var COLOR = "ANNUAIRE_DIELETTE_COULEUR_FOND"
    private var TIRANTEAU = "ANNUAIRE_DIELETTE_TIRANT_D_EAU"
    private var PUBRESTANT = "ANNUAIRE_DILETTE_PUB_RESTANT"



    var sharedPref: SharedPreferences? // : SharedPreferences = context!!.getSharedPreferences(PREF_NAME, PRIVATE_MODE)

    init {
        sharedPref = context?.getSharedPreferences(PREF_NAME, PRIVATE_MODE)
        if(sharedPref!!.getBoolean(PREF_NAME, false)){
            reset()
            sharedPref!!.edit().apply()
        }
    }

    fun setTirantEau(t: Float){
        var editor: SharedPreferences.Editor = sharedPref!!.edit()
        editor.putFloat(TIRANTEAU, t)
        editor.apply()
    }
    fun getTirantEau(): Float{
        return sharedPref!!.getFloat(TIRANTEAU, -1f)
    }

    fun setFontSize(s: Float){
        var editor: SharedPreferences.Editor = sharedPref!!.edit()
        editor.putFloat(FONTSIZE, s)
        editor.apply()
    }
        fun getFontSize(): Float{
        return sharedPref!!.getFloat(FONTSIZE, 15f)
    }

    fun setCouleur(s: Float){
        var editor: SharedPreferences.Editor = sharedPref!!.edit()
        editor.putFloat(COLOR, s)
        editor.commit()
    }
    fun getCouleur(): Float{
        return sharedPref!!.getFloat(COLOR, 0f)
        return 50f
    }

    fun setPubRestant(t: Float){
        var editor: SharedPreferences.Editor = sharedPref!!.edit()
        editor.putFloat(PUBRESTANT, t)
        editor.commit()
    }
    fun getPubRestant(): Float{
        //return sharedPref.getFloat(PUBRESTANT, -1f)
        return 30f
    }

    fun reset(){
        setTirantEau(-1f)
        setFontSize(15f)
        setCouleur(0f)
        setPubRestant(0f)
    }

}