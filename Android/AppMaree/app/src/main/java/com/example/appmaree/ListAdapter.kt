package com.example.appmaree

import android.graphics.Movie
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class ListAdapter(private val list: List<TableauHoraireViewModel.Jour>) : RecyclerView.Adapter<HoraireViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): HoraireViewHolder {
        val inflater = LayoutInflater.from(parent.context)
        return HoraireViewHolder(inflater,parent)
    }

    override fun onBindViewHolder(holder: HoraireViewHolder, position: Int) {
        val jour: TableauHoraireViewModel.Jour =list[position]
        holder.bind(jour)
    }

    override fun getItemCount(): Int =list.size



}