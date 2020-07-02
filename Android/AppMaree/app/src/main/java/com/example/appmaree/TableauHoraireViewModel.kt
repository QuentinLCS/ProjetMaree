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
 * @property tirantDEau Tirant d'eau de l'utilisateur initialisé a 0
 * @property listeHorairesTirantDEau Liste des horaires calculé avec le tirant d'eau
 * @property pair Variable pour afficher un fond blanc un jour sur deux
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

    /**
     * Dataclass contenant les données de une ligne du tableau
     */
    data class Ligne(val col1:String,var col2:String,var col3:String,var col4:String,var col5:String,val background : ArrayList<Int?>?=null)

    /**
     * Dataclass contenant les lignes d'une journée
     */
    data class Jour(val ligne1:Ligne,val ligne2:Ligne,val ligne3:Ligne,val ligne4:Ligne,val ligne5:Ligne,val background : Int?=null){}

    var tirantDEau:Double =0.0
    lateinit var listeHorairesTirantDEau:ArrayList<String>
    var pair = true
    lateinit var listJour :ArrayList<Jour>
    var listePorte =ArrayList<Porte>()
    var listeMaree =ArrayList<Maree>()
    var latitude : String =""
    var longitude : String =""

    /****************Fonctions pour le calculs des horaires avec le tirant d'eau****************/

    /**
     * Fonction pour changer la valeur du tirant d'eau
     * Si le tirant d'eau est différent de celui stocké on recharge le tableau
     *
     * @param newVar Nouveau tirant d'eau
     */
    fun actualiserTirantDEau(newVar : Double){
        if(tirantDEau!=newVar && newVar> HAUTEUR_PORTE+0.1){
            tirantDEau=newVar
            changerHoraireTirantDeau()
        }
    }

    /**
     * Fonction qui echange les valeurs du tableau avec les nouvelles valeurs calculé
     * a l'aide du tirant d'eau
     *
     */
    fun changerHoraireTirantDeau(){
        val listeHoraire=getHoraireCalculTirantDeau()
        val size=listeHoraire.size
        var i=0
        var tmp=""

        for(jour:Jour in listJour){
            jour.ligne5.col2=jour.ligne4.col2
            jour.ligne4.col2=jour.ligne3.col2
            if(jour.ligne3.col2!=""){
                jour.ligne3.col2=listeHoraire.get(i)
                i++
            }

            jour.ligne5.col3=jour.ligne4.col3
            jour.ligne4.col3=jour.ligne3.col3
            if(jour.ligne3.col3!=""){
                jour.ligne3.col3=listeHoraire.get(i)
                i++
            }

            jour.ligne5.col4=jour.ligne4.col4
            jour.ligne4.col4=jour.ligne3.col4
            if(jour.ligne3.col4!=""){
                jour.ligne3.col4=listeHoraire.get(i)
                i++
            }
            jour.ligne5.col5=jour.ligne4.col5
            jour.ligne4.col5=jour.ligne3.col5
            if(jour.ligne3.col5!="" && i<size){
                jour.ligne3.col5=listeHoraire.get(i)
                i++
            }
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
        listJour=ArrayList<Jour>()
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

        if(tirantDEau> HAUTEUR_PORTE+0.1){
            changerHoraireTirantDeau()
        }
    }

    /**
     * Fonction qui crée un nouveau jour corespondant a une journée
     * Chaque jour est lui même découpé en 5 lignes
     * On décompose les jours selons les marées et les portes
     * les marées sont triés par horaires
     *
     * @param xmlRP Parser du xml pointant vers le jour voulu
     */
    fun newRow(xmlRP: XmlResourceParser){
        var ligne1:ArrayList<String> =ArrayList<String>()
        var ligne2:ArrayList<String> =ArrayList<String>()
        var ligne3:ArrayList<String> =ArrayList<String>()
        var ligne4:ArrayList<String> =ArrayList<String>()
        var ligne5:ArrayList<String> =ArrayList<String>()
        var backgroundPorte:ArrayList<Int?> =ArrayList<Int?>()
        var backgroundMaree:ArrayList<Int?> =ArrayList<Int?>()
        var backgroundLine:Int? =null

        xmlRP.next()
        var jour:String =xmlRP.getAttributeValue(0)
        xmlRP.next()
        var date:String =xmlRP.text.split("/")[0]
        var mois :String=moisIntToString(xmlRP.text.split("/")[1].toInt())
        xmlRP.next()
        xmlRP.next()
        var portes = getXmlAttributePorte(xmlRP,"porte")
        var marees=sortMaree(getXmlAttributeMaree(xmlRP,"maree"))

        for(porte:Porte in portes){
            if(porte.heure!="" && porte.heure!="-------"){
                listePorte.add(porte)
            }
        }
        for(maree:Maree in marees){
            if(maree.heure!="--:--"){
                listeMaree.add(maree)
            }
        }

        ligne1.add(" ")
        ligne2.add(jour)
        ligne3.add(date+" ")
        ligne4.add(mois)
        ligne5.add(" ")

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

            ligne1.add(coef)
            ligne2.add(heureM)
            ligne3.add(heureP)
            ligne4.add(hauteur)
            ligne5.add(" ")
            if(colorM!=Color.WHITE){backgroundMaree.add(colorM)}
            else{backgroundMaree.add(null)}
            if(colorP!=Color.WHITE){backgroundPorte.add(colorP)}
            else{
                backgroundPorte.add(null)
            }
        }

        if(pair){
            backgroundLine=Color.WHITE
            pair=false
        }
        else{pair=true}

        listJour.add(Jour(
            Ligne(ligne1.get(0),ligne1.get(1),ligne1.get(2),ligne1.get(3),ligne1.get(4)),
            Ligne(ligne2.get(0),ligne2.get(1),ligne2.get(2),ligne2.get(3),ligne2.get(4),backgroundMaree),
            Ligne(ligne3.get(0),ligne3.get(1),ligne3.get(2),ligne3.get(3),ligne3.get(4),backgroundPorte),
            Ligne(ligne4.get(0),ligne4.get(1),ligne4.get(2),ligne4.get(3),ligne4.get(4)),
            Ligne(ligne5.get(0),ligne5.get(1),ligne5.get(2),ligne5.get(3),ligne5.get(4)),
            backgroundLine
        ))
    }

    /**
     * Fonction qui récupére les données du xml pour les marée d'une journée
     * Une marée haute comporte 4 paramètres
     * Une marée basse comporte 3 paramètres
     *
     * @param xmlRP Parser du xml qui point vers la premiere marée de la journée voulu
     * @param tagName   Nom du tag pour lequelle on veut les données
     * @return Liste de @Maree
     */
    fun getXmlAttributeMaree(xmlRP: XmlResourceParser, tagName:String):ArrayList<Maree>{
        var mareeList = ArrayList<Maree>()
        while(xmlRP.name==tagName){
            val list=ArrayList<String>()
            for(i:Int in 0..(xmlRP.attributeCount-1)){
                list.add(xmlRP.getAttributeValue(i))
            }
            if(xmlRP.eventType== XmlPullParser.START_TAG) {
                if (xmlRP.attributeCount == 3 ) {
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

    /**
     *  Fonction qui récupére les données du xml pour les portes d'une journée
     *
     * @param xmlRP Parser du xml qui point vers la premiere porte de la journée voulu
     * @param tagName Nom du tag pour lequelle on veut les données
     * @return Liste de Porte
     */
    fun getXmlAttributePorte(xmlRP: XmlResourceParser, tagName:String):ArrayList<Porte>{
        var porteList=ArrayList<Porte>()
        while(xmlRP.name==tagName) {
            val list = ArrayList<String>()
            if(xmlRP.eventType== XmlPullParser.START_TAG) {
                for (i: Int in 0..(xmlRP.attributeCount - 1)) {
                    list.add(xmlRP.getAttributeValue(i))
                }
                porteList.add(Porte(etat = list.get(0), heure = list.get(1)))
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


    /**
     * Fonction renvoie le mois en lettre
     *
     * @param mois Mois dont on veut le nom
     * @return Nom du mois
     */
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
    /*****************************************************************************/
}