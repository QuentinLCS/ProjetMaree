package com.example.appmaree

import android.content.Context
import com.google.gson.Gson

data class Sponsor(
    val name: String,
    val file: String,
    val weight: Int,
    val category: String)

class ListeSponsor (context: Context?){
    var listeSponsor : List<Sponsor> = ArrayList()
    init{
        val fileName = context?.resources?.openRawResource(R.raw.pubs)?.reader()?.readText()
        listeSponsor= Gson().fromJson(fileName , Array<Sponsor>::class.java).asList()
    }

}

