package com.example.appmaree

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProviders


/**
 *Activité principale de l'application
 * Affiche par défaut la page d'accueil
 */
class MainActivity : AppCompatActivity() {

    lateinit var viewModel : TableauHoraireViewModel


    /**
     * Fonction automatique lors de la creation de l'activité
     * Crée un view model et récupere le tableau et la liste des id
     */
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewModel = ViewModelProviders.of(this).get(TableauHoraireViewModel::class.java)
        viewModel.tableLayoutStocke=SplashScreenActivity.splashViewModel.tableLayoutStocke
        viewModel.IdTodayDate=SplashScreenActivity.splashViewModel.IdTodayDate
        viewModel.listJour=SplashScreenActivity.splashViewModel.listJour
        setContentView(R.layout.activity_main)

    }

}