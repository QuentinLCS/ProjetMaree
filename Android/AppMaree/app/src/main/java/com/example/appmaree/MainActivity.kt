package com.example.appmaree

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import android.os.Bundle
import android.os.Looper
import android.provider.Settings
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import com.google.android.gms.location.*
import com.google.android.material.bottomsheet.BottomSheetBehavior
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.bottom_sheet.*
import kotlinx.android.synthetic.main.content_main.*


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
        viewModel.listJour=SplashScreenActivity.splashViewModel.listJour
        viewModel.listeMaree=SplashScreenActivity.splashViewModel.listeMaree
        viewModel.listePorte=SplashScreenActivity.splashViewModel.listePorte
        viewModel.tirantDEau=SplashScreenActivity.splashViewModel.tirantDEau
        setContentView(R.layout.activity_main)
        var scale = resources.displayMetrics.density

        bottom_sheet.visibility=View.INVISIBLE
        val behavior = BottomSheetBehavior.from(bottom_sheet)
        bottom_sheet.post {
            behavior.state = BottomSheetBehavior.STATE_HIDDEN
        }
        behavior.setBottomSheetCallback(object : BottomSheetBehavior.BottomSheetCallback() {
            override fun onStateChanged(bottomSheet: View, newState: Int) {
                when (newState) {
                    BottomSheetBehavior.STATE_HIDDEN -> {behavior.state=BottomSheetBehavior.STATE_COLLAPSED }
                    BottomSheetBehavior.STATE_EXPANDED ->{

                    }
                    BottomSheetBehavior.STATE_COLLAPSED ->{
                        var param = home.layoutParams
                        param.height=(125*scale).toInt()
                        home.layoutParams=param
                    }
                    BottomSheetBehavior.STATE_DRAGGING -> { }
                    BottomSheetBehavior.STATE_SETTLING -> { }
                }
            }

            override fun onSlide(bottomSheet: View, slideOffset: Float) {
                if(slideOffset>0){
                    var param = home.layoutParams
                    param.height=(125*scale*(1-slideOffset)).toInt()
                    param.width==param.height
                    home.layoutParams=param}
            }
        })

        home.setOnClickListener{
            behavior.state=BottomSheetBehavior.STATE_EXPANDED
        }
    }

    override fun onBackPressed() {
    }


}