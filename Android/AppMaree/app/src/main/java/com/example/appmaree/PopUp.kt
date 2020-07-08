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

/**
 * Créer une classe PopUp qui permet d'afficher une fenêtre par dessus l'application
 * la fenêtre de popup est utilisé pour passer des publicités pour les sponsors de l'association
 * la création de la poup demande l'activité sur laquelle afficher la popup
 */
class PopUp private constructor(activity: FragmentActivity?) : PopupWindow(activity)  {

    // définie le temps entre chaque pubs
    private val tempsEntrePub: Long = 45000
    private var image: ImageView?
    private var imageArray: ArrayList<Int>
    private val handler : Handler
    private val view : View? = activity?.layoutInflater?.inflate(R.layout.activity_popup, null)
    private var pub : Boolean = true

    /**
     * Permet de transformer la classe PopUp en Singleton
     * Une seule instance de popup existe pour éviter d'avoir plusieurs images qui
     * apparaissent sur l'écran en même temps
     */
    companion object {
        private lateinit var instance: PopUp
        fun getInstance(activity: FragmentActivity?): PopUp {
            if(!::instance.isInitialized)  instance = PopUp(activity)
            return instance
        }
    }

    /**
     * Code éxécuté lors de l'instanciation de la classe PopUp
     * Affecte la fonction sur le bouton fermer pour fermer la popup et
     * en rappeler une nouvelle 45s après
     * Créer le tableau des images en fonction des poids (utilise la classe ListeSponsor dans Sponsor.kt)
     */
    init {
        contentView = view
        handler=Handler()

        width = LinearLayout.LayoutParams.MATCH_PARENT;

        val button = view?.findViewById<Button>(R.id.popupFermer)
        button?.setOnClickListener {
            dismiss()
            if(pub){
                handler.postDelayed({
                    show()
                }, tempsEntrePub)
                pub =false
            }
        }
        image = view?.findViewById(R.id.popupImage)

        val arraySponsor = ListeSponsor().listeSponsor
        imageArray = ArrayList()
        for (sponsor in arraySponsor) {
            for (i in 0..sponsor.poids)
                imageArray.add(sponsor.AdresseImage)
        }

        handler.postDelayed({
            show()
        }, tempsEntrePub)
    }

    /**
     * Affiche une image aléatoirement parmis le tableau des sponsors
     * est appelé 45s après l'ouverture de la page horaire et
     * 45s après la fermeture de la popup précédente
     */
    fun show() {
        image?.setImageResource(imageArray.get(Random.nextInt(imageArray.size)))
        showAtLocation(view, BOTTOM, 0, 0)
        pub = true
    }

    /**
     * Affiche l'image passée en paramêtre (adresse de l'image)
     * Utile pour la page Services
     */
    fun showSponsor(resource : Int) {
        image?.setImageResource(resource)
        showAtLocation(view, BOTTOM, 0, 0)
    }
}