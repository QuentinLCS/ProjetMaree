package com.example.appmaree

import android.annotation.SuppressLint
import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import androidx.core.view.updateLayoutParams
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.google.android.material.bottomsheet.BottomSheetBehavior

class DocumentationFragment: Fragment() {

    private var list: ArrayList<TextView?> = arrayListOf<TextView?>()
    private var linlayout : LinearLayout? = null
    private var cf: CoffreFort? = null
    private var fontsize: Int = 15


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_documentation, container, false)
    }


    @SuppressLint("UseRequireInsteadOfGet")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        var bottomSheet:View=activity!!.findViewById(R.id.bottom_sheet)
        val behavior =BottomSheetBehavior.from(bottomSheet)
/*Bouton services*/
        bottomSheet.findViewById<LinearLayout>(R.id.service).setOnClickListener {
            findNavController().navigate(R.id.action_documentationFragment_to_servicesFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Tailles autorisée*/
        bottomSheet.findViewById<LinearLayout>(R.id.peche).setOnClickListener {
            findNavController().navigate(R.id.action_documentationFragment_to_taillesAutoriseeFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Documentation*/
        bottomSheet.findViewById<LinearLayout>(R.id.documentation).setOnClickListener {
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton parametre*/
        bottomSheet.findViewById<LinearLayout>(R.id.settings).setOnClickListener {
            findNavController().navigate(R.id.action_documentationFragment_to_ParametreFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton A propos*/
        bottomSheet.findViewById<LinearLayout>(R.id.aPropos).setOnClickListener {
            findNavController().navigate(R.id.action_documentationFragment_to_AProposFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Appels d'urgence*/
        bottomSheet.findViewById<LinearLayout>(R.id.urgence).setOnClickListener {
            findNavController().navigate(R.id.action_documentationFragment_to_urgenceFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Boucton croix*/
        bottomSheet.findViewById<LinearLayout>(R.id.back).setOnClickListener {
            findNavController().navigate(R.id.action_documentationFragment_to_HorairesFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }

        initextex()
        changefontsize()
        changeCouleur()

    }

    fun changefontsize() {
        fontsize = cf?.getFontSize()!!.toInt()
        for(i in 0..list.size-1)
            if(i < 4 || (i >= 12 && i <= 20) || (i<=42 && i>=51) )
                list.get(i)?.setTextSize(fontsize.toFloat()-3)
            else
                list.get(i)?.setTextSize(fontsize.toFloat())
        if(cf!!.getTirantEau() < 1.6) {
            for (i in 13..16)
                list.get(i)?.setTextSize(0f)
            view?.findViewById<LinearLayout>(R.id.paratextestetantdeau)?.updateLayoutParams { height = 0 }
        }
        else
            view?.findViewById<LinearLayout>(R.id.paratextestetantdeau)?.updateLayoutParams { height = fontsize*2 }
        linlayout?.updateLayoutParams { height = fontsize*10 }
    }

    fun changeCouleur(){

        var color = cf!!.getCouleur()

        val red = -0x10000 + color.toInt()
        val green = -0xff0100 + color.toInt()
        val blue = -0xffff01 - color.toInt()
        val yellow = -0x100 + color.toInt()

        list.get(5)?.setBackgroundColor(yellow)
        list.get(6)?.setBackgroundColor(blue)
        list.get(6)?.setTextColor(Color.WHITE)
        list.get(7)?.setBackgroundColor(yellow)
        list.get(8)?.setBackgroundColor(blue)
        list.get(8)?.setTextColor(Color.WHITE)

        list.get(9)?.setBackgroundColor(green)
        list.get(10)?.setBackgroundColor(red)
        list.get(10)?.setTextColor(Color.WHITE)
        list.get(11)?.setBackgroundColor(green)
        list.get(12)?.setBackgroundColor(red)
        list.get(12)?.setTextColor(Color.WHITE)

        list.get(21)?.setBackgroundColor(yellow)
        list.get(22)?.setBackgroundColor(blue)
        list.get(22)?.setTextColor(Color.WHITE)
        list.get(23)?.setBackgroundColor(yellow)
        list.get(24)?.setBackgroundColor(blue)
        list.get(24)?.setTextColor(Color.WHITE)

        list.get(25)?.setBackgroundColor(green)
        list.get(26)?.setBackgroundColor(red)
        list.get(26)?.setTextColor(Color.WHITE)
        list.get(27)?.setBackgroundColor(green)
        list.get(28)?.setBackgroundColor(red)
        list.get(28)?.setTextColor(Color.WHITE)

        list.get(34)?.setBackgroundColor(yellow)
        list.get(35)?.setBackgroundColor(blue)
        list.get(35)?.setTextColor(Color.WHITE)
        list.get(36)?.setBackgroundColor(yellow)
        list.get(37)?.setBackgroundColor(blue)
        list.get(37)?.setTextColor(Color.WHITE)

        list.get(38)?.setBackgroundColor(green)
        list.get(39)?.setBackgroundColor(red)
        list.get(39)?.setTextColor(Color.WHITE)
        list.get(40)?.setBackgroundColor(green)
        list.get(41)?.setBackgroundColor(red)
        list.get(41)?.setTextColor(Color.WHITE)

        list.get(54)?.setBackgroundColor(green)
        list.get(55)?.setBackgroundColor(red)
        list.get(55)?.setTextColor(Color.WHITE)
        list.get(56)?.setBackgroundColor(green)
        list.get(57)?.setBackgroundColor(red)
        list.get(57)?.setTextColor(Color.WHITE)

    }

    fun initextex(){

        linlayout = view?.findViewById(R.id.exempleparamlayout)
        list.add(view?.findViewById(R.id.paramtextest0))
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
        list.add(view?.findViewById(R.id.paramtextest21))
        list.add(view?.findViewById(R.id.paramtextest22))
        list.add(view?.findViewById(R.id.paramtextest23))
        list.add(view?.findViewById(R.id.paramtextest24))
        list.add(view?.findViewById(R.id.paramtextest25))
        list.add(view?.findViewById(R.id.paramtextest26))
        list.add(view?.findViewById(R.id.paramtextest28))
        list.add(view?.findViewById(R.id.paramtextest29))
        list.add(view?.findViewById(R.id.paramtextest30))
        list.add(view?.findViewById(R.id.paramtextest31))
        list.add(view?.findViewById(R.id.paramtextest32))
        list.add(view?.findViewById(R.id.paramtextest33))
        list.add(view?.findViewById(R.id.paramtextest34))
        list.add(view?.findViewById(R.id.paramtextest35))
        list.add(view?.findViewById(R.id.paramtextest36))
        list.add(view?.findViewById(R.id.paramtextest37))
        list.add(view?.findViewById(R.id.paramtextest38))
        list.add(view?.findViewById(R.id.paramtextest39))
        list.add(view?.findViewById(R.id.paramtextest40))
        list.add(view?.findViewById(R.id.paramtextest41))
        list.add(view?.findViewById(R.id.paramtextest42))
        list.add(view?.findViewById(R.id.paramtextest43))
        list.add(view?.findViewById(R.id.paramtextest44))
        list.add(view?.findViewById(R.id.paramtextest45))
        list.add(view?.findViewById(R.id.paramtextest46))
        list.add(view?.findViewById(R.id.paramtextest47))
        list.add(view?.findViewById(R.id.paramtextest48))
        list.add(view?.findViewById(R.id.paramtextest49))
        list.add(view?.findViewById(R.id.paramtextest50))
        list.add(view?.findViewById(R.id.paramtextest51))
        list.add(view?.findViewById(R.id.paramtextest52))
        list.add(view?.findViewById(R.id.paramtextest53))
        list.add(view?.findViewById(R.id.paramtextest54))
        list.add(view?.findViewById(R.id.paramtextest55))
        list.add(view?.findViewById(R.id.paramtextest56))
        list.add(view?.findViewById(R.id.paramtextest57))
        list.add(view?.findViewById(R.id.paramtextest58))
        list.add(view?.findViewById(R.id.paramtextest59))
        list.add(view?.findViewById(R.id.paramtextest60))
        list.add(view?.findViewById(R.id.paramtextest61))
        list.add(view?.findViewById(R.id.paramtextest62))

        cf = CoffreFort(this.context)
        //Toast.makeText(this.context, "fontsize : ${cf?.getFontSize()}", Toast.LENGTH_LONG).show()



    }


}