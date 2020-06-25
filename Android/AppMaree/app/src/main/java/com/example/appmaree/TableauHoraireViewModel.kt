package com.example.appmaree

import android.app.Application
import android.content.res.XmlResourceParser
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.TableLayout
import android.widget.TableRow
import android.widget.TextView
import androidx.lifecycle.AndroidViewModel
import org.xmlpull.v1.XmlPullParser

private const val HAUTEUR_PORTE =1.5

class TableauHoraireViewModel(application: Application) : AndroidViewModel(application) {
    var tableLayoutStocke : TableLayout= TableLayout(getApplication())
    var listeIdStocke:ArrayList<Int> = ArrayList<Int>()
    var tirantDEau:Double =0.0
    lateinit var listeHorairesTirantDEau:ArrayList<String>
    var pair = true


    fun getTableLayout(): TableLayout? {
        val parentViewGroup=tableLayoutStocke?.parent as ViewGroup?
        parentViewGroup?.removeAllViews()
      return tableLayoutStocke
    }

    fun setTableLayout(newTableLayout: TableLayout){
        tableLayoutStocke=newTableLayout
    }

    fun setListeId(newlist :ArrayList<Int>){
        listeIdStocke=newlist
    }

    fun getListId(): ArrayList<Int> {
        return listeIdStocke
    }

    /****************Fonctions pour le calculs des horaires avec le tirant d'eau****************/
    fun actualiserTirantDEau(newVar : Double){
        if(tirantDEau!=newVar){
            tirantDEau=newVar
            tableLayoutStocke.removeAllViews()
            xmlToTable()
        }
    }

    fun calculHeureSelonTiranDEau(porte: HorairesFragment.Porte, mareeMin: HorairesFragment.Maree,mareeMax: HorairesFragment.Maree): String {
        var heureMareeMax : Double =convertHeureDouble(mareeMax.heure,":")
        var heureMareeMin : Double =convertHeureDouble(mareeMin.heure,":")
        var heurePorte : Double =convertHeureDouble(porte.heure,"h")
        val hauteurMareeMax : Double=mareeMax.hauteur.replace(",",".").toDouble()
        val hauteurMareeMin : Double =mareeMin.hauteur.replace(",",".").toDouble()
        var hauteurMax : Double = 0.0
        if(heureMareeMin>heureMareeMax)heureMareeMax+=24
        if(heureMareeMax<heurePorte)heurePorte-=24
        if(heureMareeMin>heurePorte)heurePorte+=24
        val dureeMaree : Double=heureMareeMax-heureMareeMin
        val marnage : Double = hauteurMareeMax-hauteurMareeMin
        var sinus=Math.sin(Math.PI/2*((heurePorte-heureMareeMin)/dureeMaree))
        var hauteurCalculeePorte=sinus*sinus*marnage+hauteurMareeMin
        var hauteurCalculeePlusTirantDEau=hauteurCalculeePorte+ tirantDEau - HAUTEUR_PORTE
        if(marnage>0) { hauteurMax = hauteurMareeMax}
        else{hauteurMax=hauteurMareeMin}

        if(hauteurCalculeePlusTirantDEau>hauteurMax || hauteurCalculeePlusTirantDEau+0.1>hauteurMax){
            return "-----"
        }
        var heure :Double = dureeMaree/Math.PI*2.0*Math.asin(Math.sqrt((hauteurCalculeePlusTirantDEau-hauteurMareeMin)/marnage))+heureMareeMin
        if(heure>24){heure-=24}
        var retour : String =""+Math.floor(heure).toInt()+"h"
        if(Math.floor(heure%1*60)<10){retour+="0"}
        retour+=Math.floor(heure%1*60).toInt()
        return retour
    }

    fun convertHeureDouble(heure:String, separator: String):Double{
        var heureInt : Double=heure.split(separator)[0].toDouble()
        heureInt += heure.split(separator)[1].toDouble()/60
        return heureInt
    }

    fun getHoraireCalculTirantDeau():ArrayList<String>{
        var newlisteHorairesTirantDEau = ArrayList<String>()
        var listePorte =ArrayList<HorairesFragment.Porte>()
        var listeMaree =ArrayList<HorairesFragment.Maree>()
        var xmlResourceParser: XmlResourceParser = getApplication<Application>().resources.getXml(R.xml.maree)
        var eventType: Int = xmlResourceParser.getEventType()
        while (eventType != XmlPullParser.END_DOCUMENT) {
            when{
                eventType== XmlPullParser.START_TAG && xmlResourceParser.name =="porte"-> {
                    listePorte.addAll(getXmlAttributePorte(xmlResourceParser,"porte",false))
                }
                eventType== XmlPullParser.START_TAG && xmlResourceParser.name =="maree"-> {
                    listeMaree.addAll(sortMaree(getXmlAttributeMaree(xmlResourceParser,"maree",false)))
                }
                else ->eventType=xmlResourceParser.next()
            }
        }
        for(i in 0..listeMaree.size-2){
            newlisteHorairesTirantDEau.add(calculHeureSelonTiranDEau(listePorte.get(i),listeMaree.get(i),listeMaree.get(i+1)))
        }

        return newlisteHorairesTirantDEau
    }
    /********************************************************************************/



    /****************Fonctions pour la creation du tableau des horaires****************/
    fun xmlToTable(){
    if(tirantDEau> HAUTEUR_PORTE+0.1){
        listeHorairesTirantDEau= ArrayList<String>()
        listeHorairesTirantDEau = getHoraireCalculTirantDeau()
    }


        var xmlResourceParser: XmlResourceParser = getApplication<Application>().resources.getXml(R.xml.maree)
        var eventType: Int = xmlResourceParser.getEventType()
        while (eventType != XmlPullParser.END_DOCUMENT) {
            if(eventType== XmlPullParser.START_TAG && xmlResourceParser.name =="jour"){
                newRow(xmlResourceParser)
                eventType=xmlResourceParser.next()
            }
            else{
                eventType=xmlResourceParser.next()
            }
        }
        tableLayoutStocke.setBackgroundResource(R.drawable.horaires_gradient_background)
    }

    fun newRow(xmlRP: XmlResourceParser){
        xmlRP.next()
        var jour:String =xmlRP.getAttributeValue(0)
        xmlRP.next()
        var date:String =xmlRP.text
        xmlRP.next()
        xmlRP.next()
        var portes = getXmlAttributePorte(xmlRP,"porte")
        var marees=sortMaree(getXmlAttributeMaree(xmlRP,"maree"))
        val row1 = TableRow(getApplication())
        row1.layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)
        val row2 = TableRow(getApplication())
        row2.layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)
        val row3 = TableRow(getApplication())
        row3.layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)
        val row4 = TableRow(getApplication())
        row4.layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)
        val row5 = TableRow(getApplication())
        row5.layoutParams = ViewGroup.LayoutParams(
            ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)

        row1.addView(addTextView(" "))
        row2.addView(addTextView(jour))
        row3.addView(addTextView(date+" ",id=true))
        row4.addView(addTextView(" "))
        row5.addView(addTextView(" "))
        for(i in 0..3){

            var coef :String=" "
            var heureM:String=""
            var heureP:String=""
            var hauteur:String=""
            var colorM:Int= Color.WHITE
            var colorP:Int= Color.WHITE
            when(i){
                0->{coef=marees.get(0).coef;heureM=marees.get(0).heure;heureP=portes.get(0).heure;hauteur=marees.get(0).hauteur;colorM=getColorMaree(marees.get(0));colorP=getColorPorte(portes.get(0))}
                1->{coef=marees.get(1).coef;heureM=marees.get(1).heure;heureP=portes.get(1).heure;hauteur=marees.get(1).hauteur;colorM=getColorMaree(marees.get(1));colorP=getColorPorte(portes.get(1))}
                2->{coef=marees.get(2).coef;heureM=marees.get(2).heure;heureP=portes.get(2).heure;hauteur=marees.get(2).hauteur;colorM=getColorMaree(marees.get(2));colorP=getColorPorte(portes.get(2))}
                3->{coef=marees.get(3).coef;heureM=marees.get(3).heure;heureP=portes.get(3).heure;hauteur=marees.get(3).hauteur;colorM=getColorMaree(marees.get(3));colorP=getColorPorte(portes.get(3))}
            }

            row1.addView(addTextView(coef))
            row2.addView(addTextView(heureM,colorM))
            if(tirantDEau< HAUTEUR_PORTE || heureP==""){
                row3.addView(addTextView(heureP,colorP))
                row4.addView(addTextView(hauteur))
                row5.addView(addTextView(" "))}
            else{
                if(listeHorairesTirantDEau.size>0){
                row3.addView(addTextView(listeHorairesTirantDEau!!.removeAt(0),colorP))}
                else{
                    row3.addView(addTextView("-----"))
                }
                row4.addView(addTextView(heureP))
                row5.addView(addTextView(hauteur))
            }


        }
        if(pair){
            row1.setBackgroundColor(Color.WHITE)
            row2.setBackgroundColor(Color.WHITE)
            row3.setBackgroundColor(Color.WHITE)
            row4.setBackgroundColor(Color.WHITE)
            row5.setBackgroundColor(Color.WHITE)
            pair=false
        }
        else{pair=true}
        tableLayoutStocke.addView(row1)
        tableLayoutStocke.addView(row2)
        tableLayoutStocke.addView(row3)
        tableLayoutStocke.addView(row4)
        tableLayoutStocke.addView(row5)
    }

    fun getXmlAttributeMaree(xmlRP: XmlResourceParser, tagName:String,withBlank:Boolean=true):ArrayList<HorairesFragment.Maree>{
        var mareeList = ArrayList<HorairesFragment.Maree>()
        while(xmlRP.name==tagName){
            val list=ArrayList<String>()
            for(i:Int in 0..(xmlRP.attributeCount-1)){
                list.add(xmlRP.getAttributeValue(i))
            }
            if(xmlRP.eventType== XmlPullParser.START_TAG) {
                if (xmlRP.attributeCount == 3 ) {
                    if (withBlank || list.get(2)!="--:--"){
                    mareeList.add(
                        HorairesFragment.Maree(
                            etat = list.get(0),
                            heure = list.get(2),
                            hauteur = list.get(1)
                        )
                    )}
                } else {
                    if(withBlank || list.get(3)!="--:--") {
                        mareeList.add(
                        HorairesFragment.Maree(
                            etat = list.get(1),
                            heure = list.get(3),
                            hauteur = list.get(2),
                            coef = list.get(0)
                        )
                    )}
                }
            }
            xmlRP.next()
        }
        return mareeList
    }

    fun getXmlAttributePorte(xmlRP: XmlResourceParser, tagName:String,withBlank: Boolean=true):ArrayList<HorairesFragment.Porte>{
        var porteList=ArrayList<HorairesFragment.Porte>()
        while(xmlRP.name==tagName) {
            val list = ArrayList<String>()
            if(xmlRP.eventType== XmlPullParser.START_TAG) {
                for (i: Int in 0..(xmlRP.attributeCount - 1)) {
                    list.add(xmlRP.getAttributeValue(i))
                }
                if(withBlank || !withBlank && (list.get(1)!="" && list.get(1)!="-------")){
                porteList.add(HorairesFragment.Porte(etat = list.get(0), heure = list.get(1)))}
            }

            xmlRP.next()
        }
        return porteList
    }

    fun sortMaree(marees:ArrayList<HorairesFragment.Maree>): ArrayList<HorairesFragment.Maree> {
        var newList = ArrayList<HorairesFragment.Maree>()
        while(marees.size>0){
            var min =0
            for(i in 1..marees.size-1){
                if(compareHoursInf(marees.get(i).heure,marees.get(min).heure,":")){
                    min=i
                }
            }
            newList.add(marees.get(min))
            marees.removeAt(min)
        }
        return newList
    }

    fun compareHoursInf(hours1:String,hours2:String,separator:String):Boolean{
        var h1=hours1.split(separator)[0]
        var h2=hours2.split(separator)[0]
        when{
            h1==""||h1=="--"||h1=="-------"->return false
            h2==""||h2=="--"||h2=="-------"->return true
            else-> return h1.toInt()<=h2.toInt()
        }
    }

    fun addTextView(textToAdd:String, color:Int= Color.WHITE, id:Boolean=false): TextView {
        val textview = TextView(getApplication())
        var addText=textToAdd
        when(textToAdd){"--:--","---","--.--"->addText=""}
        textview.apply {
            layoutParams = TableRow.LayoutParams(TableRow.LayoutParams.WRAP_CONTENT,
                TableRow.LayoutParams.WRAP_CONTENT,0.2F)
            text = addText
            gravity= Gravity.CENTER
        }
        if(id){
            textview.id= View.generateViewId()
            textview.setFocusableInTouchMode(true)
            listeIdStocke.add(textview.id)
        }
        if(color!=Color.WHITE){textview.setBackgroundColor(color)}
        if(color==Color.BLUE){textview.setTextColor(Color.WHITE)}
        return textview
    }

    fun getColor(value:String):Int{
        var color:Int= Color.WHITE
        when(value){
            "PM"->color= Color.BLUE
            "BM"->color= Color.YELLOW
            "ouverture"->color= Color.GREEN
            "fermeture"->color= Color.RED
        }
        return color
    }

    fun getColorMaree(maree: HorairesFragment.Maree):Int{
        if(maree.heure=="--:--"){
            return Color.WHITE
        }
        else{
            return getColor(maree.etat)
        }
    }

    fun getColorPorte(porte: HorairesFragment.Porte):Int{
        if(porte.heure==""||porte.heure=="-------"){
            return Color.WHITE
        }
        else{
            return getColor(porte.etat)
        }
    }

    /*****************************************************************************/
}