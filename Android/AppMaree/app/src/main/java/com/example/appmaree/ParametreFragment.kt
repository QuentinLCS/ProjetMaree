package com.example.appmaree

import android.annotation.SuppressLint
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.core.view.updateLayoutParams
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
    private var text1 : TextView? = null
    private var text2 : TextView? = null
    private var text3 : TextView? = null
    private var text4 : TextView? = null
    private var text5 : TextView? = null
    private var text6 : TextView? = null
    private var text7 : TextView? = null
    private var text8 : TextView? = null
    private var text9 : TextView? = null
    private var text10 : TextView? =null
    private var text11 : TextView? =null
    private var text12 : TextView? =null
    private var text13 : TextView? =null
    private var text14 : TextView? =null
    private var text15 : TextView? =null
    private var text16 : TextView? =null
    private var text17 : TextView? =null
    private var text18 : TextView? =null
    private var text19 : TextView? =null
    private var text20 : TextView? =null
    private var linlayout : LinearLayout? = null
    private var fontsize : Int = 15
    private var color : Int = 50
    //private var cf = CoffreFort(this.context)
    private var progressBarColor: ProgressBar? = null
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
    @SuppressLint("UseRequireInsteadOfGet")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel=activity.run { ViewModelProviders.of(this!!).get(TableauHoraireViewModel::class.java)  }

        view.findViewById<Button>(R.id.tirantDEauButton).setOnClickListener {
                viewModel.actualiserTirantDEau(tirantDEauEditText.text.toString())
            findNavController().navigate(R.id.action_ParametreFragment_to_HorairesFragment)
        }

        view.findViewById<Button>(R.id.bTailleTextPlus).setOnClickListener {
            if(fontsize >= 25)
                Toast.makeText(this.context, "Taille police déjà minimisée", Toast.LENGTH_SHORT).show()
            else{
                //cf.setFontSize(cf.getFontSize()+1)
                fontsize++
                changefontsize()
            }

        }
        view.findViewById<Button>(R.id.bTailleTextMoins).setOnClickListener {
            if(fontsize <= 10)
                Toast.makeText(this.context, "Taille police déjà minimisée", Toast.LENGTH_SHORT).show()
            else{
                //cf.setFontSize(cf.getFontSize()-1)
                fontsize--
                changefontsize()
            }
        }

        view.findViewById<Button>(R.id.bParamReset).setOnClickListener {
            //cf.reset()
            Toast.makeText(this.context, "paramettres reset", Toast.LENGTH_SHORT).show()
        }




        var bottomSheet:View=activity!!.findViewById(R.id.bottom_sheet)
        val behavior =BottomSheetBehavior.from(bottomSheet)

        /*Bouton services*/
        bottomSheet.findViewById<LinearLayout>(R.id.service).setOnClickListener {
            findNavController().navigate(R.id.action_ParametreFragment_to_servicesFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Tailles autorisée*/
        bottomSheet.findViewById<LinearLayout>(R.id.peche).setOnClickListener {
            findNavController().navigate(R.id.action_ParametreFragment_to_taillesAutoriseeFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Documentation*/
        bottomSheet.findViewById<LinearLayout>(R.id.documentation).setOnClickListener {
            findNavController().navigate(R.id.action_ParametreFragment_to_documentationFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton parametre*/
        bottomSheet.findViewById<LinearLayout>(R.id.settings).setOnClickListener {
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton A propos*/
        bottomSheet.findViewById<LinearLayout>(R.id.aPropos).setOnClickListener {
            findNavController().navigate(R.id.action_ParametreFragment_to_AProposFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Appels d'urgence*/
        bottomSheet.findViewById<LinearLayout>(R.id.urgence).setOnClickListener {
            findNavController().navigate(R.id.action_ParametreFragment_to_urgenceFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Boucton croix*/
        bottomSheet.findViewById<LinearLayout>(R.id.back).setOnClickListener {
            findNavController().navigate(R.id.action_ParametreFragment_to_HorairesFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        initextex()
        changefontsize()
        changeCouleur()
    }

    fun changefontsize() {
        //fontsize = cf.getFontSize()
        text1?.setTextSize(fontsize.toFloat())
        text2?.setTextSize(fontsize.toFloat())
        text3?.setTextSize(fontsize.toFloat())
        text4?.setTextSize(fontsize.toFloat())
        text5?.setTextSize(fontsize.toFloat())
        text6?.setTextSize(fontsize.toFloat())
        text7?.setTextSize(fontsize.toFloat())
        text8?.setTextSize(fontsize.toFloat())
        text9?.setTextSize(fontsize.toFloat())
        text10?.setTextSize(fontsize.toFloat())
        text11?.setTextSize(fontsize.toFloat())
        text12?.setTextSize(fontsize.toFloat())
        text13?.setTextSize(fontsize.toFloat())
        text14?.setTextSize(fontsize.toFloat())
        text15?.setTextSize(fontsize.toFloat())
        text16?.setTextSize(fontsize.toFloat())
        text17?.setTextSize(fontsize.toFloat())
        text18?.setTextSize(fontsize.toFloat())
        text19?.setTextSize(fontsize.toFloat())
        text20?.setTextSize(fontsize.toFloat())
        linlayout?.updateLayoutParams { height = fontsize*5 }
    }

    fun changeCouleur(){
        text5?.setBackgroundColor(3)
    }

    fun initextex(){
        text1  = view?.findViewById(R.id.paramtextest1)
        text2  = view?.findViewById(R.id.paramtextest2)
        text3  = view?.findViewById(R.id.paramtextest3)
        text4  = view?.findViewById(R.id.paramtextest4)
        text5  = view?.findViewById(R.id.paramtextest5)
        text6  = view?.findViewById(R.id.paramtextest6)
        text7  = view?.findViewById(R.id.paramtextest7)
        text8  = view?.findViewById(R.id.paramtextest8)
        text9  = view?.findViewById(R.id.paramtextest9)
        text10 = view?.findViewById(R.id.paramtextest10)
        text11 = view?.findViewById(R.id.paramtextest11)
        text12 = view?.findViewById(R.id.paramtextest12)
        text13 = view?.findViewById(R.id.paramtextest13)
        text14 = view?.findViewById(R.id.paramtextest14)
        text15 = view?.findViewById(R.id.paramtextest15)
        text16 = view?.findViewById(R.id.paramtextest16)
        text17 = view?.findViewById(R.id.paramtextest17)
        text18 = view?.findViewById(R.id.paramtextest18)
        text19 = view?.findViewById(R.id.paramtextest19)
        text20 = view?.findViewById(R.id.paramtextest20)
        linlayout = view?.findViewById(R.id.exempleparamlayout)
        progressBarColor = view?.findViewById(R.id.progressBarColor)



    }



}