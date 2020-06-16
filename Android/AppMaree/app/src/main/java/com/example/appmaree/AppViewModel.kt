package com.example.appmaree

import android.view.ViewGroup
import android.widget.TableLayout
import androidx.lifecycle.ViewModel

class AppViewModel : ViewModel() {
    var tableLayoutStocke : TableLayout?=null
    var listeIdStocke:ArrayList<Int> = ArrayList<Int>()

    fun getTableLayout(): TableLayout? {
        val parentViewGroup=tableLayoutStocke?.parent as ViewGroup?
        parentViewGroup?.removeAllViews()
      return tableLayoutStocke
    }

    fun setTableLayout(newTableLayout: TableLayout){
        tableLayoutStocke=newTableLayout
    }

    fun setListeId(newlist :ArrayList<Int>){
        listeIdStocke=newlist
    }

    fun getListId(): ArrayList<Int> {
        return listeIdStocke
    }
}