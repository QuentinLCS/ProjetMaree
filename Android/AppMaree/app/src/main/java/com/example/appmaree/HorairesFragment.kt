package com.example.appmaree

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.LinearLayout
import android.widget.ListAdapter
import android.widget.TextView
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
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
    var IdToday:Int =0
    private lateinit var viewModel:TableauHoraireViewModel
    lateinit var listeJours:ArrayList<TableauHoraireViewModel.Jour>
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
        listeJours=viewModel.listJour
       /*scroll.addView(viewModel.getTableLayout())
        IdToday=viewModel.getIdToday()
        scrollToDate()*/
        list_recycler_view.apply {
            layoutManager=LinearLayoutManager(activity)
            adapter=ListAdapter(listeJours)
            scrollToPosition(Calendar.getInstance().get(Calendar.DAY_OF_YEAR)-1)
        }


       view.findViewById<Button>(R.id.buttontmp).setOnClickListener {
            findNavController().navigate(R.id.action_HorairesFragment_to_ParametreFragment)
        }
        var popup = PopUp(activity)
        val mainHandler = Handler(Looper.getMainLooper())

        mainHandler.postDelayed(object : Runnable {
            override fun run() {
                mainHandler.postDelayed(this, tempsEntrePub.toLong())
                popup.show(view)
            }
        }, tempsEntrePub.toLong())
    }

    /**
     * Fonction pour scroll le tableau jusqu'a la date du jour
     * Focus la vue sur la case trouvée
     */
    fun scrollToDate(){
        var textViewScroll: TextView? = view?.findViewById<TextView>(IdToday)
            textViewScroll?.requestFocus()
    }


}