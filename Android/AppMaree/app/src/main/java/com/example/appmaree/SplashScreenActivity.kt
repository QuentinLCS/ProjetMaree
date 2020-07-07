package com.example.appmaree

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProviders

/**
 * Écran de chargement lors du lancement de l'application
 * Le tableau des horaires est crée et transmis au main
 * @property <SPLASH_TIME_OUT> Temps minimale de chargement
 */
class SplashScreenActivity : AppCompatActivity() {
   companion object {lateinit var splashViewModel : TableauHoraireViewModel}
    private val SPLASH_TIME_OUT:Long=500 // 0.5 sec

    /**
     * Fonction automatique lors de la creation de l'activité
     * Créer un ViewModel et lance la création du tableau des horaires
     * Puis lance le MainActivity
     */
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        Handler().postDelayed({
            val intent = Intent(this,MainActivity::class.java)
            splashViewModel = ViewModelProviders.of(this).get(TableauHoraireViewModel::class.java)
            splashViewModel.xmlToTable()
            var  cf = CoffreFort(this)
            splashViewModel.actualiserTirantDEau(cf.getTirantEau().toString())
            startActivity(intent)
            finish()
        }, SPLASH_TIME_OUT)
    }
}