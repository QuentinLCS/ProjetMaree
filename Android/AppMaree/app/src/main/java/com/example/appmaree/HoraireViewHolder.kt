package com.example.appmaree

import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TableRow
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class HoraireViewHolder (var context: Context?, inflater: LayoutInflater, parent: ViewGroup): RecyclerView.ViewHolder(inflater.inflate(R.layout.list_item, parent, false)){

    private var J1L1C1View : TextView? = null
    private var J1L1C2View : TextView? = null
    private var J1L1C3View : TextView? = null
    private var J1L1C4View : TextView? = null
    private var J1L1C5View : TextView? = null
    private var J1L2C1View : TextView? = null
    private var J1L2C2View : TextView? = null
    private var J1L2C3View : TextView? = null
    private var J1L2C4View : TextView? = null
    private var J1L2C5View : TextView? = null
    private var J1L3C1View : TextView? = null
    private var J1L3C2View : TextView? = null
    private var J1L3C3View : TextView? = null
    private var J1L3C4View : TextView? = null
    private var J1L3C5View : TextView? = null
    private var J1L4C1View : TextView? = null
    private var J1L4C2View : TextView? = null
    private var J1L4C3View : TextView? = null
    private var J1L4C4View : TextView? = null
    private var J1L4C5View : TextView? = null
    private var J1L5C1View : TextView? = null
    private var J1L5C2View : TextView? = null
    private var J1L5C3View : TextView? = null
    private var J1L5C4View : TextView? = null
    private var J1L5C5View : TextView? = null
    private var J1L1View : TableRow? = null
    private var J1L2View : TableRow? = null
    private var J1L3View : TableRow? = null
    private var J1L4View : TableRow? = null
    private var J1L5View : TableRow? = null
    private var red: Int = 0
    private var green: Int = 0
    private var yellow: Int= 0
    private var blue: Int= 0
    private var cf: CoffreFort? = null

    init{
        cf = CoffreFort(context)
        val red = -0x10000 + cf!!.getCouleur().toInt()
        val green = -0xff0100 + cf!!.getCouleur().toInt()
        val blue = -0xffff01 - cf!!.getCouleur().toInt()
        val yellow = -0x100 + cf!!.getCouleur().toInt()

        J1L1C1View = itemView.findViewById(R.id.J1L1C1)
        J1L1C2View = itemView.findViewById(R.id.J1L1C2)
        J1L1C3View = itemView.findViewById(R.id.J1L1C3)
        J1L1C4View = itemView.findViewById(R.id.J1L1C4)
        J1L1C5View = itemView.findViewById(R.id.J1L1C5)
        J1L2C1View = itemView.findViewById(R.id.J1L2C1)
        J1L2C2View = itemView.findViewById(R.id.J1L2C2)
        J1L2C3View = itemView.findViewById(R.id.J1L2C3)
        J1L2C4View = itemView.findViewById(R.id.J1L2C4)
        J1L2C5View = itemView.findViewById(R.id.J1L2C5)
        J1L3C1View = itemView.findViewById(R.id.J1L3C1)
        J1L3C2View = itemView.findViewById(R.id.J1L3C2)
        J1L3C3View = itemView.findViewById(R.id.J1L3C3)
        J1L3C4View = itemView.findViewById(R.id.J1L3C4)
        J1L3C5View = itemView.findViewById(R.id.J1L3C5)
        J1L4C1View = itemView.findViewById(R.id.J1L4C1)
        J1L4C2View = itemView.findViewById(R.id.J1L4C2)
        J1L4C3View = itemView.findViewById(R.id.J1L4C3)
        J1L4C4View = itemView.findViewById(R.id.J1L4C4)
        J1L4C5View = itemView.findViewById(R.id.J1L4C5)
        J1L5C1View = itemView.findViewById(R.id.J1L5C1)
        J1L5C2View = itemView.findViewById(R.id.J1L5C2)
        J1L5C3View = itemView.findViewById(R.id.J1L5C3)
        J1L5C4View = itemView.findViewById(R.id.J1L5C4)
        J1L5C5View = itemView.findViewById(R.id.J1L5C5)

        J1L1View = itemView.findViewById(R.id.J1L1)
        J1L2View = itemView.findViewById(R.id.J1L2)
        J1L3View = itemView.findViewById(R.id.J1L3)
        J1L4View = itemView.findViewById(R.id.J1L4)
        J1L5View = itemView.findViewById(R.id.J1L5)
    }

    fun bind(jour:TableauHoraireViewModel.Jour){
        if(jour.background== Color.WHITE){
            J1L1View?.setBackgroundColor(Color.WHITE)
            J1L2View?.setBackgroundColor(Color.WHITE)
            J1L3View?.setBackgroundColor(Color.WHITE)
            J1L4View?.setBackgroundColor(Color.WHITE)
            J1L5View?.setBackgroundColor(Color.WHITE)
        }
        else{
            J1L1View?.setBackgroundResource(0)
            J1L2View?.setBackgroundResource(0)
            J1L3View?.setBackgroundResource(0)
            J1L4View?.setBackgroundResource(0)
            J1L5View?.setBackgroundResource(0)
        }
        J1L1C1View?.text = jour.ligne1.col1
        J1L1C1View?.setTextSize(cf!!.getFontSize())
        J1L1C2View?.text = jour.ligne1.col2
        J1L1C2View?.setTextSize(cf!!.getFontSize())
        J1L1C3View?.text = jour.ligne1.col3
        J1L1C3View?.setTextSize(cf!!.getFontSize())
        J1L1C4View?.text = jour.ligne1.col4
        J1L1C4View?.setTextSize(cf!!.getFontSize())
        J1L1C5View?.text = jour.ligne1.col5
        J1L1C5View?.setTextSize(cf!!.getFontSize())
        J1L2C1View?.text = jour.ligne2.col1
        J1L2C1View?.setTextSize(cf!!.getFontSize())
        J1L2C2View?.text = jour.ligne2.col2
        J1L2C2View?.setTextSize(cf!!.getFontSize())
        jour.ligne2.background?.get(0)?.let { J1L2C2View?.setBackgroundColor(it);J1L2C2View?.setTextColor(getColorText(it)) }
        J1L2C3View?.text = jour.ligne2.col3
        J1L2C3View?.setTextSize(cf!!.getFontSize())
        jour.ligne2.background?.get(1)?.let { J1L2C3View?.setBackgroundColor(it);J1L2C3View?.setTextColor(getColorText(it)) }
        J1L2C4View?.text = jour.ligne2.col4
        J1L2C4View?.setTextSize(cf!!.getFontSize())
        jour.ligne2.background?.get(2)?.let { J1L2C4View?.setBackgroundColor(it);J1L2C4View?.setTextColor(getColorText(it)) }
        J1L2C5View?.text = jour.ligne2.col5
        J1L2C5View?.setTextSize(cf!!.getFontSize())
        jour.ligne2.background?.get(3)?.let { J1L2C5View?.setBackgroundColor(it);J1L2C5View?.setTextColor(getColorText(it)) }
        J1L3C1View?.text = jour.ligne3.col1
        J1L3C1View?.setTextSize(cf!!.getFontSize())
        J1L3C2View?.text = jour.ligne3.col2
        J1L3C2View?.setTextSize(cf!!.getFontSize())
        jour.ligne3.background?.get(0)?.let { J1L3C2View?.setBackgroundColor(it);J1L3C2View?.setTextColor(getColorText(it)) }
        J1L3C3View?.text = jour.ligne3.col3
        J1L3C3View?.setTextSize(cf!!.getFontSize())
        jour.ligne3.background?.get(1)?.let { J1L3C3View?.setBackgroundColor(it);J1L3C3View?.setTextColor(getColorText(it)) }
        J1L3C4View?.text = jour.ligne3.col4
        J1L3C4View?.setTextSize(cf!!.getFontSize())
        jour.ligne3.background?.get(2)?.let { J1L3C4View?.setBackgroundColor(it);J1L3C4View?.setTextColor(getColorText(it)) }
        J1L3C5View?.text = jour.ligne3.col5
        J1L3C5View?.setTextSize(cf!!.getFontSize())
        jour.ligne3.background?.get(3)?.let { J1L3C5View?.setBackgroundColor(it);J1L3C5View?.setTextColor(getColorText(it)) }
        J1L4C1View?.text = jour.ligne4.col1
        J1L4C1View?.setTextSize(cf!!.getFontSize())
        J1L4C2View?.text = jour.ligne4.col2
        J1L4C2View?.setTextSize(cf!!.getFontSize())
        J1L4C3View?.text = jour.ligne4.col3
        J1L4C3View?.setTextSize(cf!!.getFontSize())
        J1L4C4View?.text = jour.ligne4.col4
        J1L4C4View?.setTextSize(cf!!.getFontSize())
        J1L4C5View?.text = jour.ligne4.col5
        J1L4C5View?.setTextSize(cf!!.getFontSize())

        if(jour.ligne5.col2!=""){
            val viewl5=itemView.findViewById<TableRow>(R.id.J1L5)
            val paraml5 =viewl5.layoutParams
            paraml5.height=ViewGroup.LayoutParams.WRAP_CONTENT
            viewl5.layoutParams=paraml5
        }
        J1L5C1View?.text = jour.ligne5.col1
        J1L5C2View?.text = jour.ligne5.col2
        J1L5C3View?.text = jour.ligne5.col3
        J1L5C4View?.text = jour.ligne5.col4
        J1L5C5View?.text = jour.ligne5.col5
    }

    fun getColorText(backgroundColor : Int):Int{
        if(backgroundColor==Color.YELLOW || backgroundColor==Color.GREEN ){
            return Color.BLACK
        }
        else{
            return Color.WHITE
        }
    }
}