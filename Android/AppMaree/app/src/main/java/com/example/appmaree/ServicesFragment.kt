package com.example.appmaree

import android.annotation.SuppressLint
import android.content.res.Resources
import android.os.Bundle
import android.os.Handler
import android.text.Layout
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.RelativeLayout
import android.widget.TextView
import android.widget.Toast
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.core.content.ContextCompat
import androidx.core.content.res.ResourcesCompat
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.google.android.material.bottomsheet.BottomSheetBehavior

class ServicesFragment: Fragment() {

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_services, container, false)
    }

    @SuppressLint("UseRequireInsteadOfGet")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        var popUp = PopUp.getInstance(activity)
        var arraySponsor = popUp.arraySponsor

        var arrayCategorie : HashMap<Categorie,ArrayList<Sponsor>> = HashMap()
        var cat : Categorie

        for(sponsor in arraySponsor){
            cat=sponsor.categorie
            if(arrayCategorie.containsKey(cat)){
                arrayCategorie[cat]?.add(sponsor)
            }else{
                arrayCategorie[cat] = ArrayList()
                arrayCategorie[cat]?.add(sponsor)
            }
        }

        val layout = activity?.findViewById<LinearLayout>(R.id.service_layout)
        var textView: TextView
        for(categorie in arrayCategorie.keys){
            textView = TextView(activity)
            textView.layoutParams = LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT)
            textView.text = categorie.texte
            textView.textSize = resources.getDimension(R.dimen.tailleServiceCategorie)
            textView.setTextColor(ResourcesCompat.getColor(resources,R.color.colorServiceCategorie,null))
            layout?.addView(textView)

            for(sponsor in arrayCategorie[categorie]!!){
                textView = TextView(activity)
                textView.layoutParams = LinearLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT)
                textView.text = sponsor.nom
                textView.textSize = resources.getDimension(R.dimen.tailleServiceSponsor)
                textView.setTextColor(ResourcesCompat.getColor(resources,R.color.colorServiceSponsor,null))
                textView.isClickable = true
                layout?.addView(textView)
                textView.setOnClickListener{
                    popUp.showSponsor(sponsor.AdresseImage)
                }
            }
        }



        var bottomSheet:View=activity!!.findViewById(R.id.bottom_sheet)
        val behavior =BottomSheetBehavior.from(bottomSheet)
/*Bouton services*/
        bottomSheet.findViewById<LinearLayout>(R.id.service).setOnClickListener {
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Tailles autorisée*/
        bottomSheet.findViewById<LinearLayout>(R.id.peche).setOnClickListener {
            findNavController().navigate(R.id.action_servicesFragment_to_taillesAutoriseeFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Documentation*/
        bottomSheet.findViewById<LinearLayout>(R.id.documentation).setOnClickListener {
            findNavController().navigate(R.id.action_servicesFragment_to_documentationFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton parametre*/
        bottomSheet.findViewById<LinearLayout>(R.id.settings).setOnClickListener {
            findNavController().navigate(R.id.action_servicesFragment_to_ParametreFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton A propos*/
        bottomSheet.findViewById<LinearLayout>(R.id.aPropos).setOnClickListener {
            findNavController().navigate(R.id.action_servicesFragment_to_AProposFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Appels d'urgence*/
        bottomSheet.findViewById<LinearLayout>(R.id.urgence).setOnClickListener {
            findNavController().navigate(R.id.action_servicesFragment_to_urgenceFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Boucton croix*/
        bottomSheet.findViewById<LinearLayout>(R.id.back).setOnClickListener {
            findNavController().navigate(R.id.action_servicesFragment_to_HorairesFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
    }
}