package com.example.appmaree

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.navigation.fragment.findNavController

/**
 * Fragment de la page d'accueil comportant le texte de prévention et le bouton pour accepter
 */
class AccueilFragment : Fragment() {

    /**
     * Fonction automatique lors de la création du fragment
     * Initialise le fragment et affiche la vue de l'accueil
     */
    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_accueil, container, false)
    }

    /**
     * Fonction automatique lors de la création de la vue
     * Lie le bouton à la navigation de la page d'accueil vers la page des horaires
     */
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        //view.findViewById<Button>(R.id.buttontmp2).visibility=View.INVISIBLE
        PopUp(activity,view)
        view.findViewById<Button>(R.id.button_first).setOnClickListener {
            findNavController().navigate(R.id.action_AccueilFragment_to_HorairesFragment)
        }
    }
}