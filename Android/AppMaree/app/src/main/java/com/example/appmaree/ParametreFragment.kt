package com.example.appmaree

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.LinearLayout
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.fragment.findNavController
import com.google.android.material.bottomsheet.BottomSheetBehavior
import kotlinx.android.synthetic.main.fragment_parametre.*

/**
 * Fragment de la page des paramètres
 * Possibilité de rentrer les tirant d'eau
 *
 */
class ParametreFragment : Fragment() {
    private lateinit var viewModel:TableauHoraireViewModel

    /**
     * Fonction automatique lors de la création du fragment
     * Initialise le fragment et affiche la vue des paramètres
     */
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_parametre, container, false)
    }

    /**
     *  Fonction automatique lors de la création de la vue
     *  Recupére le ViewModel crée par le MainActivity
     *  Lie le bouton a la fonction pour actualiser le tirant d'eau
     */
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel=activity.run { ViewModelProviders.of(this!!).get(TableauHoraireViewModel::class.java)  }

        view.findViewById<Button>(R.id.tirantDEauButton).setOnClickListener {
            viewModel.actualiserTirantDEau(tirantDEauEditText.text.toString().toDouble())
            findNavController().navigate(R.id.action_ParametreFragment_to_HorairesFragment)
        }

        var bottomSheet:View=activity!!.findViewById(R.id.bottom_sheet)
        bottomSheet.findViewById<LinearLayout>(R.id.settings).setOnClickListener {
            bottomSheet.post{
                BottomSheetBehavior.from(bottomSheet).state=BottomSheetBehavior.STATE_COLLAPSED
            }
        }
    }
}