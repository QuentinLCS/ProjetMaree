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


class HorairesFragment : Fragment() {
    var listeId:ArrayList<Int> = ArrayList<Int>()
    private lateinit var viewModel:TableauHoraireViewModel
    data class Maree(val etat:String,val heure:String,val hauteur:String,val coef:String=" ")
    data class Porte(val etat:String,val heure:String)

    override fun onCreateView(
            inflater: LayoutInflater, container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_horaires, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel=activity.run {ViewModelProviders.of(this!!).get(TableauHoraireViewModel::class.java)  }
        scroll.addView(viewModel.getTableLayout())
        listeId=viewModel.getListId()
        scrollToDate(getTodayDate())

        view.findViewById<Button>(R.id.buttontmp).setOnClickListener {
            findNavController().navigate(R.id.action_HorairesFragment_to_ParametreFragment)
        }
        var popup = PopUp(activity,view.width)
        val mainHandler = Handler(Looper.getMainLooper())
        mainHandler.post(object : Runnable {
            override fun run() {
                popup.show()
                mainHandler.postDelayed(this, 45000)
            }
        })
    }



    fun getTodayDate():String{
        val sdf = SimpleDateFormat("dd/MM/yyyy")
        val currentDate = sdf.format(Date())
        return currentDate
    }

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