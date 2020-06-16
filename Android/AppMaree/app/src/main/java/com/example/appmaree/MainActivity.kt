package com.example.appmaree

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProviders

class MainActivity : AppCompatActivity() {

    lateinit var viewModel : TableauHoraireViewModel



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewModel= ViewModelProviders.of(this).get(TableauHoraireViewModel::class.java)
        viewModel.xmlToTable()
        setContentView(R.layout.activity_main)
    }


}