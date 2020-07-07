package com.example.appmaree

import android.annotation.SuppressLint
import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.annotation.MainThread
import androidx.core.view.updateLayoutParams
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import androidx.navigation.fragment.findNavController
import com.google.android.material.bottomsheet.BottomSheetBehavior
import kotlinx.android.synthetic.main.fragment_parametre.*
import kotlin.math.ceil

/**
 * Fragment de la page des paramètres
 * Possibilité de rentrer les tirant d'eau
 *
 */
class ParametreFragment : Fragment() {
    private lateinit var viewModel:TableauHoraireViewModel
    private var list: ArrayList<TextView?> = arrayListOf<TextView?>()
    private var linlayout : LinearLayout? = null
    private var fontsize : Int = 15
    private var color : Float = 50f
    private var cf: CoffreFort? = null
    private var seekBar: SeekBar? = null
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

        if(viewModel.tirantDEau!=0.0){
            view.findViewById<EditText>(R.id.tirantDEauEditText).hint="Votre tirant d'eau actuel est de ${viewModel.tirantDEau} m"
        }

        view.findViewById<Button>(R.id.tirantDEauButton).setOnClickListener {
                viewModel.actualiserTirantDEau(tirantDEauEditText.text.toString())
            if(tirantDEauEditText.text.toString()!=""){
                cf?.setTirantEau(tirantDEauEditText.text.toString().toFloat())
                Toast.makeText(this.context, "tirant d'eau sauvegardé à ${cf?.getTirantEau()}m", Toast.LENGTH_SHORT).show()
                findNavController().navigate(R.id.action_ParametreFragment_to_HorairesFragment)
            }
            else
                Toast.makeText(this.context, "Veuillez mettre une valeur si vous voulez valider le tirant d'eau", Toast.LENGTH_SHORT).show()
        }
        cf = CoffreFort(this.context)

        view.findViewById<Button>(R.id.bTailleTextPlus).setOnClickListener {
            if(fontsize >= 25)
                Toast.makeText(this.context, "Taille police déjà maximisée", Toast.LENGTH_SHORT).show()
            else{
                cf?.setFontSize(cf!!.getFontSize()+1)
                Toast.makeText(this.context, "${cf!!.getTirantEau()}", Toast.LENGTH_SHORT).show()
                changefontsize()
            }
        }
        view.findViewById<Button>(R.id.bTailleTextMoins).setOnClickListener {
            if(fontsize <= 10)
                Toast.makeText(this.context, "Taille police déjà minimisée", Toast.LENGTH_SHORT).show()
            else{
                cf?.setFontSize(cf!!.getFontSize()-1)
                changefontsize()
            }
        }

        view.findViewById<Button>(R.id.bParamReset).setOnClickListener {
            cf?.reset()
            view.findViewById<ProgressBar>(R.id.progressBarColor).setProgress(cf!!.getCouleur().toInt())
            changefontsize()
            changeCouleur()
            Toast.makeText(this.context, "paramètres reset", Toast.LENGTH_SHORT).show()
        }
        seekBar = view.findViewById<SeekBar>(R.id.progressBarColor)
        seekBar?.setProgress(cf!!.getCouleur().toInt())
        seekBar?.setOnSeekBarChangeListener(object :
            SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seek: SeekBar,
                                           progress: Int, fromUser: Boolean) {
                cf?.setCouleur((seek.progress*1.5).toFloat())
                changeCouleur()
            }
            override fun onStartTrackingTouch(seekBar: SeekBar?){}
            override fun onStopTrackingTouch(seekBar: SeekBar?) {}

        })

        var bottomSheet:View=activity!!.findViewById(R.id.bottom_sheet)
        val behavior = BottomSheetBehavior.from(bottomSheet)

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
        fontsize = cf?.getFontSize()!!.toInt()
        for(i in 0..20)
            if(i < 4 || i >= 12)
                list.get(i)?.setTextSize(fontsize.toFloat()-3)
            else
                list.get(i)?.setTextSize(fontsize.toFloat())
        if(cf!!.getTirantEau() < 1.6) {
            for (i in 12..15)
                list.get(i)?.setTextSize(0f)
            view?.findViewById<LinearLayout>(R.id.paratextestetantdeau)?.updateLayoutParams { height = 0 }
        }
        else
            view?.findViewById<LinearLayout>(R.id.paratextestetantdeau)?.updateLayoutParams { height = fontsize*2 }
        linlayout?.updateLayoutParams { height = fontsize*4 }

    }

    fun changeCouleur(){

        /*var red : Color = Color.valueOf(255f, indice/2, indice/2 )
        var yellow : Color = Color.valueOf(125+indice, 125+indice, indice/2)
        var blue : Color = Color.valueOf(indice/2, indice/2, 255f)
        var green : Color = Color.valueOf(indice/2, 255f, indice/2) */
        color = cf!!.getCouleur()

        val red = -0x10000 + color.toInt()
        val green = -0xff0100 + color.toInt()
        val blue = -0xffff01 - (color.toInt()/2)
        val yellow = -0x100 + color.toInt()

        list.get(4)?.setBackgroundColor(blue)
        list.get(4)?.setTextColor(Color.WHITE)
        list.get(5)?.setBackgroundColor(yellow)
        list.get(6)?.setBackgroundColor(blue)
        list.get(6)?.setTextColor(Color.WHITE)
        list.get(7)?.setBackgroundColor(yellow)

        list.get(8)?.setBackgroundColor(green)
        list.get(9)?.setBackgroundColor(red)
        list.get(9)?.setTextColor(Color.WHITE)
        list.get(10)?.setBackgroundColor(green)
        list.get(11)?.setBackgroundColor(red)
        list.get(11)?.setTextColor(Color.WHITE)


    }

    fun initextex(){

        linlayout = view?.findViewById(R.id.exempleparamlayout)
        list.add(view?.findViewById(R.id.paramtextest1))
        list.add(view?.findViewById(R.id.paramtextest2))
        list.add(view?.findViewById(R.id.paramtextest3))
        list.add(view?.findViewById(R.id.paramtextest4))
        list.add(view?.findViewById(R.id.paramtextest5))
        list.add(view?.findViewById(R.id.paramtextest6))
        list.add(view?.findViewById(R.id.paramtextest7))
        list.add(view?.findViewById(R.id.paramtextest8))
        list.add(view?.findViewById(R.id.paramtextest9))
        list.add(view?.findViewById(R.id.paramtextest10))
        list.add(view?.findViewById(R.id.paramtextest11))
        list.add(view?.findViewById(R.id.paramtextest12))
        list.add(view?.findViewById(R.id.paramtextest13))
        list.add(view?.findViewById(R.id.paramtextest14))
        list.add(view?.findViewById(R.id.paramtextest15))
        list.add(view?.findViewById(R.id.paramtextest16))
        list.add(view?.findViewById(R.id.paramtextest17))
        list.add(view?.findViewById(R.id.paramtextest18))
        list.add(view?.findViewById(R.id.paramtextest19))
        list.add(view?.findViewById(R.id.paramtextest20))
        list.add(view?.findViewById(R.id.paramtextest0))


    }



}