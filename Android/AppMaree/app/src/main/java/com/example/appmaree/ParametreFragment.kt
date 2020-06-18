package com.example.appmaree

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.fragment.findNavController
import kotlinx.android.synthetic.main.fragment_parametre.*

class ParametreFragment : Fragment() {
    private lateinit var viewModel:TableauHoraireViewModel

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_parametre, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel=activity.run { ViewModelProviders.of(this!!).get(TableauHoraireViewModel::class.java)  }

        view.findViewById<Button>(R.id.tirantDEauButton).setOnClickListener {
            viewModel.actualiserTirantDEau(tirantDEauEditText.text.toString().toDouble())
            findNavController().navigate(R.id.action_ParametreFragment_to_HorairesFragment)
        }
    }
}