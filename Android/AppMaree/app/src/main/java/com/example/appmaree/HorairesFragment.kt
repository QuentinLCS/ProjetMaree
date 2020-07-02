package com.example.appmaree

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.android.synthetic.main.fragment_horaires.*
import java.util.*

/**
 * Fragment de la page des horaires
 * @property <listeId> Liste des Id des cases du tableau avec une date
 * @property <viewModel> ViewModel qui contient les données partager entre les fragments
 */
class HorairesFragment : Fragment() {
    var IdToday:Int =0
    private lateinit var viewModel:TableauHoraireViewModel
    lateinit var listeJours:ArrayList<TableauHoraireViewModel.Jour>


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
     *  Passe la liste des jours au recycler view
     */
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel=activity.run {ViewModelProviders.of(this!!).get(TableauHoraireViewModel::class.java)  }
        listeJours=viewModel.listJour
        list_recycler_view.apply {
            layoutManager=LinearLayoutManager(activity)
            adapter=ListAdapter(listeJours)
            scrollToPosition(Calendar.getInstance().get(Calendar.DAY_OF_YEAR)-1)
        }


       view.findViewById<Button>(R.id.buttontmp).setOnClickListener {
            findNavController().navigate(R.id.action_HorairesFragment_to_securiteFragment)
        }

        PopUp(activity,view)
    }
}