package com.example.appmaree

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProviders

class SplashScreenActivity : AppCompatActivity() {
   companion object {lateinit var splashViewModel : TableauHoraireViewModel}
    private val SPLASH_TIME_OUT:Long=500 // 0.5 sec
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        Handler().postDelayed({
            val intent = Intent(this,MainActivity::class.java)
            splashViewModel = ViewModelProviders.of(this).get(TableauHoraireViewModel::class.java)
            splashViewModel.xmlToTable()
            startActivity(intent)
            finish()
        }, SPLASH_TIME_OUT)
    }
}