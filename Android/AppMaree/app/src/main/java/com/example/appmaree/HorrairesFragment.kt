package com.example.appmaree

import android.content.res.XmlResourceParser
import android.graphics.Color
import android.os.Bundle
import android.view.Gravity
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TableRow
import android.widget.TextView
import androidx.navigation.fragment.findNavController
import kotlinx.android.synthetic.main.fragment_horraires.*
import org.xmlpull.v1.XmlPullParser

/**
 * A simple [Fragment] subclass as the second destination in the navigation.
 */
class HorrairesFragment : Fragment() {
    data class Maree(val etat:String,val heure:String,val hauteur:String,val coef:String=" ")
    data class Porte(val etat:String,val heure:String)

    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_horraires, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        xmlToTable()

    }

    fun xmlToTable(){
        var xmlResourceParser: XmlResourceParser = resources.getXml(R.xml.maree)
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
        val row1 = TableRow(activity)
        row1.layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)
        val row2 = TableRow(activity)
        row2.layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)
        val row3 = TableRow(activity)
        row3.layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)
        val row4 = TableRow(activity)
        row4.layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)
        val row5 = TableRow(activity)
        row5.layoutParams = ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
            ViewGroup.LayoutParams.WRAP_CONTENT)

        row1.addView(addTextView(" "))
        row2.addView(addTextView(jour))
        row3.addView(addTextView(date+"  "))
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
                1->{coef=marees.get(1).coef;heureM=marees.get(1).heure;heureP=portes.get(1).heure;hauteur=marees.get(0).hauteur;colorM=getColorMaree(marees.get(1));colorP=getColorPorte(portes.get(1))}
                2->{coef=marees.get(2).coef;heureM=marees.get(2).heure;heureP=portes.get(2).heure;hauteur=marees.get(2).hauteur;colorM=getColorMaree(marees.get(2));colorP=getColorPorte(portes.get(2))}
                3->{coef=marees.get(3).coef;heureM=marees.get(3).heure;heureP=portes.get(3).heure;hauteur=marees.get(3).hauteur;colorM=getColorMaree(marees.get(3));colorP=getColorPorte(portes.get(3))}
            }

            row1.addView(addTextView(coef))
            row2.addView(addTextView(heureM,colorM))
            row3.addView(addTextView(heureP,colorP))
            row4.addView(addTextView(hauteur))
            row5.addView(addTextView(" "))

        }

        tableLayoutHorraires.addView(row1)
        tableLayoutHorraires.addView(row2)
        tableLayoutHorraires.addView(row3)
        tableLayoutHorraires.addView(row4)
        tableLayoutHorraires.addView(row5)
    }

    fun getXmlAttributeMaree(xmlRP: XmlResourceParser, tagName:String):ArrayList<Maree>{
        var mareeList = ArrayList<Maree>()
        while(xmlRP.name==tagName){
            val list=ArrayList<String>()
            for(i:Int in 0..(xmlRP.attributeCount-1)){
                list.add(xmlRP.getAttributeValue(i))
            }
            if(xmlRP.eventType==XmlPullParser.START_TAG) {
                if (xmlRP.attributeCount == 3) {
                    mareeList.add(
                        Maree(
                            etat = list.get(0),
                            heure = list.get(2),
                            hauteur = list.get(1)
                        )
                    )
                } else {
                    mareeList.add(
                        Maree(
                            etat = list.get(1),
                            heure = list.get(3),
                            hauteur = list.get(2),
                            coef = list.get(0)
                        )
                    )
                }
            }
            xmlRP.next()
        }
        return mareeList
    }

    fun getXmlAttributePorte(xmlRP:XmlResourceParser,tagName:String):ArrayList<Porte>{
        var porteList=ArrayList<Porte>()
        while(xmlRP.name==tagName) {
            val list = ArrayList<String>()
            if(xmlRP.eventType==XmlPullParser.START_TAG) {
                for (i: Int in 0..(xmlRP.attributeCount - 1)) {
                    list.add(xmlRP.getAttributeValue(i))
                }
                porteList.add(Porte(etat=list.get(0),heure=list.get(1)))
            }

            xmlRP.next()
        }
        return porteList
    }

    fun sortMaree(marees:ArrayList<Maree>): ArrayList<Maree> {
        var newList = ArrayList<Maree>()
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

    fun addTextView(textToAdd:String,color:Int=Color.WHITE): TextView {
        val textview = TextView(activity)
        var addText=textToAdd
        when(textToAdd){"--:--","---","--.--"->addText=""}
        textview.apply {
            layoutParams = TableRow.LayoutParams(TableRow.LayoutParams.WRAP_CONTENT,
                TableRow.LayoutParams.WRAP_CONTENT,0.2F)
            text = addText
            gravity= Gravity.CENTER
        }
        textview.setBackgroundColor(color)
        return textview
    }

    fun getColor(value:String):Int{
        var color:Int=Color.WHITE
        when(value){
            "PM"->color=Color.BLUE
            "BM"->color=Color.YELLOW
            "ouverture"->color=Color.GREEN
            "fermeture"->color=Color.RED
        }
        return color
    }

    fun getColorMaree(maree:Maree):Int{
        if(maree.heure=="--:--"){
            return Color.WHITE
        }
        else{
            return getColor(maree.etat)
        }
    }

    fun getColorPorte(porte:Porte):Int{
        if(porte.heure==""||porte.heure=="-------"){
            return Color.WHITE
        }
        else{
            return getColor(porte.etat)
        }
    }
}