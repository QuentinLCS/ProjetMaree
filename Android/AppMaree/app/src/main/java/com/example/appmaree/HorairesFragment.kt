package com.example.appmaree

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.fragment.findNavController
import kotlinx.android.synthetic.main.fragment_horaires.*
import java.text.SimpleDateFormat
import java.util.*
import kotlin.collections.ArrayList

/**
 * Fragment de la page des horaires
 * @property <listeId> Liste des Id des cases du tableau avec une date
 * @property <viewModel> ViewModel qui contient les données partager entre les fragments
 */
class HorairesFragment : Fragment() {
    var listeId:ArrayList<Int> = ArrayList<Int>()
    private lateinit var viewModel:TableauHoraireViewModel
    private val tempsEntrePub = 40000

    /**
     * Fonction automatique lors de la création du fragment
     * Initialise le fragment et affiche la vue du tableau des horaires
     */
    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_horaires, container, false)
    }

    /**
     *  Fonction automatique lors de la création de la vue
     *  Recupére le ViewModel crée par le MainActivity
     *  Ajoute le tableau des horaires dans le scroll de l'affichage
     *  Récupére la liste des Id stockée dans le ViewModel
     *  Lance le scoll du tableau a la date du jour
     */
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel=activity.run {ViewModelProviders.of(this!!).get(TableauHoraireViewModel::class.java)  }
        scroll.addView(viewModel.getTableLayout())
        listeId=viewModel.getListId()
        scrollToDate(getTodayDate())

        view.findViewById<Button>(R.id.buttontmp).setOnClickListener {
            findNavController().navigate(R.id.action_HorairesFragment_to_ParametreFragment)
        }
        var popup = PopUp(activity)
        val mainHandler = Handler(Looper.getMainLooper())

        mainHandler.postDelayed(object : Runnable {
            override fun run() {
                mainHandler.postDelayed(this, tempsEntrePub.toLong())
                popup.show()
            }
        }, tempsEntrePub.toLong())
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

    /**
     * Fonction pour scroll le tableau jusqu'a la date indiqué
     * @param date au format dd/mm/yyyy
     * Parcours le tableau grâce a la liste des id jusqu'a trouver un date identique au paramètre
     * Puis focus la vue sur la case trouvée
     */
    fun scrollToDate(date:String){
        var i =0
        var textViewScroll: TextView? = view?.findViewById<TextView>(listeId.get(i))
        while((textViewScroll?.text?.replace("\\s".toRegex(),""))!=date && i<(listeId.size-1)){
            i++
            textViewScroll = view?.findViewById<TextView>(listeId.get(i))
        }
            textViewScroll?.requestFocus()

    }


}