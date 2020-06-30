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
import java.text.SimpleDateFormat
import java.util.*
import kotlin.collections.ArrayList

private const val HAUTEUR_PORTE =1.5

/**
 * ViewModel permettant de partager les données entre les fragments
 * Fonctions pour le tableau des horaires
 * @param <tableLayoutStocke> TableLayout qui stock le tableau des horaires
 * @param <listeIdStocke> Liste des ID des cases contenant une date
 * @param <tirantDEau> Tirant d'eau de l'utilisateur initialisé a 0
 * @param <listeHorairesTirantDEau> Liste des horaires calculé avec le tirant d'eau
 * @param <pair> Variable pour afficher un fond blanc un jour sur deux
 */
class TableauHoraireViewModel(application: Application) : AndroidViewModel(application) {

    /**
     *Data class pour stocker les données d'une marée
     *
     * @property etat  Haute ou Basse
     * @property heure Au format hh:mm
     * @property hauteur En mètre
     * @property coef Coeficcient de la marée
     */
    data class Maree(val etat:String,val heure:String,val hauteur:String,val coef:String=" ")

    /**
     * Data class pour stocker les données d'une porte
     *
     * @property etat Ouverture ou Fermeture
     * @property heure Au format HHhMM
     */
    data class Porte(val etat:String,val heure:String)


    var tableLayoutStocke : TableLayout= TableLayout(getApplication())
    var IdTodayDate:Int = 0
    var tirantDEau:Double =0.0
    lateinit var listeHorairesTirantDEau:ArrayList<String>
    var pair = true

    /**
     * Fonction pour récupérer le tableau des horaires
     *
     * @return TableLayout tableau des horaires
     */
    fun getTableLayout(): TableLayout? {
        val parentViewGroup=tableLayoutStocke?.parent as ViewGroup?
        parentViewGroup?.removeAllViews()
      return tableLayoutStocke
    }

    /**
     * Fonction pour stocké le tableau
     *
     * @param newTableLayout Tableau a stocké
     */
    fun setTableLayout(newTableLayout: TableLayout){
        tableLayoutStocke=newTableLayout
    }

    /**
     * Fonction pour stocké la liste des ID
     *
     * @param newlist liste d'ID à stocké
     */
    fun setIdTpdayDate(newId :Int){
        IdTodayDate=newId
    }

    /**
     * Fonction pour récupérer la liste des ID
     *
     * @return Liste des ID
     */
    fun getIdToday(): Int {
        return IdTodayDate
    }

    /****************Fonctions pour le calculs des horaires avec le tirant d'eau****************/

    /**
     * Fonction pour changer la valeur du tirant d'eau
     * Si le tirant d'eau est différent de celui stocké on recharge le tableau
     *
     * @param newVar Nouveau tirant d'eau
     */
    fun actualiserTirantDEau(newVar : Double){
        if(tirantDEau!=newVar){
            tirantDEau=newVar
            tableLayoutStocke.removeAllViews()
            xmlToTable()
        }
    }

    /**
     * Fonction pour calculer l'horaire d'entrée ou de sortie en fonction du tirant d'eau
     *
     * @param porte Porte (ouverture/fermeture) pour laquelle on veut calculer le nouvelle horaire
     * @param mareeMin Maree avant la porte
     * @param mareeMax Maree après la porte
     * @return Nouvelle horaire calculé
     */
    fun calculHeureSelonTiranDEau(porte: Porte, mareeMin: Maree,mareeMax: Maree): String {
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

    /**
     * Fonction qui converti l'heure en décimal
     *
     * @param heure Heure a convertir
     * @param separator Séparateur entre les heures et les minutes (: ou h)
     * @return Double correspond à l'heure
     */
    fun convertHeureDouble(heure:String, separator: String):Double{
        var heureInt : Double=heure.split(separator)[0].toDouble()
        heureInt += heure.split(separator)[1].toDouble()/60
        return heureInt
    }

    /**
     * Fonction qui calcule tout les horaires en fonction du tirant et les stokcs dans une liste
     *
     * @return Liste des nouveaux horaires
     */
    fun getHoraireCalculTirantDeau():ArrayList<String>{
        var newlisteHorairesTirantDEau = ArrayList<String>()
        var listePorte =ArrayList<Porte>()
        var listeMaree =ArrayList<Maree>()
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

    /**
     * Fonction qui crée le tableau à partir du xml contenant les données
     * Parcours le xml de tag en tag et appelle newRow pour chaque jour
     *
     */
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

    /**
     * Fonction qui crée une nouvelle ligne corespondant a une journée
     * Chaque jour est lui même découpé en 5 lignes
     * On décompose les jours selons les marées et les portes
     * les marées sont triés par horaires
     *
     * @param xmlRP Parser du xml pointant vers le jour voulu
     */
    fun newRow(xmlRP: XmlResourceParser){
        xmlRP.next()
        var jour:String =xmlRP.getAttributeValue(0)
        xmlRP.next()
        var id=false
        if(xmlRP.text==getTodayDate()){id=true}
        var date:String =xmlRP.text.split("/")[0]
        var mois :String=moisIntToString(xmlRP.text.split("/")[1].toInt())
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
        row3.addView(addTextView(date+" ",id=id))
        row4.addView(addTextView(mois))
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

    /**
     * Fonction qui récupére les données du xml pour les marée d'une journée
     * Une marée haute comporte 4 paramètres
     * Une marée basse comporte 3 paramètres
     *
     * @param xmlRP Parser du xml qui point vers la premiere marée de la journée voulu
     * @param tagName   Nom du tag pour lequelle on veut les données
     * @param withBlank Boolean pour choisir si on veut sélectionner les marée vides
     * @return Liste de @Maree
     */
    fun getXmlAttributeMaree(xmlRP: XmlResourceParser, tagName:String,withBlank:Boolean=true):ArrayList<Maree>{
        var mareeList = ArrayList<Maree>()
        while(xmlRP.name==tagName){
            val list=ArrayList<String>()
            for(i:Int in 0..(xmlRP.attributeCount-1)){
                list.add(xmlRP.getAttributeValue(i))
            }
            if(xmlRP.eventType== XmlPullParser.START_TAG) {
                if (xmlRP.attributeCount == 3 ) {
                    if (withBlank || list.get(2)!="--:--"){
                    mareeList.add(
                        Maree(
                            etat = list.get(0),
                            heure = list.get(2),
                            hauteur = list.get(1)
                        )
                    )}
                } else {
                    if(withBlank || list.get(3)!="--:--") {
                        mareeList.add(
                        Maree(
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

    /**
     *  Fonction qui récupére les données du xml pour les portes d'une journée
     *
     * @param xmlRP Parser du xml qui point vers la premiere porte de la journée voulu
     * @param tagName Nom du tag pour lequelle on veut les données
     * @param withBlank  Boolean pour choisir si on veut sélectionner les portes vides
     * @return Liste de Porte
     */
    fun getXmlAttributePorte(xmlRP: XmlResourceParser, tagName:String,withBlank: Boolean=true):ArrayList<Porte>{
        var porteList=ArrayList<Porte>()
        while(xmlRP.name==tagName) {
            val list = ArrayList<String>()
            if(xmlRP.eventType== XmlPullParser.START_TAG) {
                for (i: Int in 0..(xmlRP.attributeCount - 1)) {
                    list.add(xmlRP.getAttributeValue(i))
                }
                if(withBlank || !withBlank && (list.get(1)!="" && list.get(1)!="-------")){
                porteList.add(Porte(etat = list.get(0), heure = list.get(1)))}
            }

            xmlRP.next()
        }
        return porteList
    }

    /**
     * Fonction qui trie une liste de marées dans l'ordre horaires
     *
     * @param marees Liste des marées à trié
     * @return Liste des marées triés
     */
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

    /**
     * Fonction qui verifie qu'une heure est inférieur à une autre
     *
     * @param hours1 Première heure
     * @param hours2 Deuxième heure
     * @param separator Séparateur entre les heures et les minutes (: ou h)
     * @return Booléen hours1<hours2
     */
    fun compareHoursInf(hours1:String,hours2:String,separator:String):Boolean{
        var h1=hours1.split(separator)[0]
        var h2=hours2.split(separator)[0]
        when{
            h1==""||h1=="--"||h1=="-------"->return false
            h2==""||h2=="--"||h2=="-------"->return true
            else-> return h1.toInt()<=h2.toInt()
        }
    }

    /**
     * Fonction qui créer un TextView avec le texte données
     *
     * @param textToAdd Texte à ajouté au TextView
     * @param color Couleur de fond du TextView
     * @param id    Boolean pour savoir si le TextView doit avoir un ID
     * @return Le TextView créé
     */
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
            IdTodayDate=textview.id
        }
        if(color!=Color.WHITE){textview.setBackgroundColor(color)}
        if(color==Color.BLUE){textview.setTextColor(Color.WHITE)}
        return textview
    }

    /**
     * Fonction qui retourne la couleur de background d'un TextView
     *
     * @param value Etat à tester
     * @return Couleur obtenue
     */
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

    /**
     * Fonction qui retourne la couleur de background d'un TextView d'une marre
     * En prenant en compte le cas d'une maree vide
     *
     * @param maree La maree à tester
     * @return Couleur obtenue
     */
    fun getColorMaree(maree: Maree):Int{
        if(maree.heure=="--:--"){
            return Color.WHITE
        }
        else{
            return getColor(maree.etat)
        }
    }

    /**
     * Fonction qui retourne la couleur de background d'un TextView d'une porte
     * En prenant en compte le cas d'une porte vide
     *
     *
     * @param porte La porte à tester
     * @return Couleur obtenue
     */
    fun getColorPorte(porte: Porte):Int{
        if(porte.heure==""||porte.heure=="-------"){
            return Color.WHITE
        }
        else{
            return getColor(porte.etat)
        }
    }

   fun moisIntToString(mois:Int): String {
       when(mois){
           1->return "Janvier"
           2->return "Février"
           3->return "Mars"
           4->return "Avril"
           5->return "Mai"
           6->return "Juin"
           7->return "Juillet"
           8->return "Août"
           9->return "Septemnre"
           10->return "Octobre"
           11->return "Novembre"
           12->return "Décembre"
           else-> return ""
       }
   }

    /**
     * Fonction pour obtenir la date du jour
     * @return Date du jour en String au format dd/mm/yyyy
     */
    fun getTodayDate():String{
        val sdf = SimpleDateFormat("dd/MM/yyyy")
        val currentDate = sdf.format(Date())
        return currentDate
    }
    /*****************************************************************************/
}