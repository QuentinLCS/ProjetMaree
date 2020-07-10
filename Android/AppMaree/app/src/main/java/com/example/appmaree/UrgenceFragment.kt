package com.example.appmaree

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationManager
import android.os.Bundle
import android.os.Looper
import android.provider.Settings
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import com.google.android.material.bottomsheet.BottomSheetBehavior
import androidx.navigation.fragment.findNavController
import com.google.android.gms.location.*

class UrgenceFragment: Fragment() {
    private lateinit var viewModel:TableauHoraireViewModel
    val PERMISSION_ID = 42
    lateinit var mFusedLocationClient: FusedLocationProviderClient

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_urgence, container, false)
    }

    @SuppressLint("UseRequireInsteadOfGet")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel=activity.run { ViewModelProviders.of(this!!).get(TableauHoraireViewModel::class.java)  }
        mFusedLocationClient = LocationServices.getFusedLocationProviderClient(activity as Activity)
        getLastLocation()
        view.findViewById<Button>(R.id.btn_urgence1).setOnClickListener(){
            var param =view.findViewById<TextView>(R.id.textUrgence1).layoutParams
            if(param.height!=ViewGroup.LayoutParams.WRAP_CONTENT){
                param.height=ViewGroup.LayoutParams.WRAP_CONTENT
            }
            else{
              param.height=0
            }
            view.findViewById<TextView>(R.id.textUrgence1).layoutParams=param
        }

        view.findViewById<Button>(R.id.btn_urgence2).setOnClickListener(){
            var param =view.findViewById<TextView>(R.id.textUrgence2).layoutParams
            if(param.height!=ViewGroup.LayoutParams.WRAP_CONTENT){
                param.height=ViewGroup.LayoutParams.WRAP_CONTENT
            }
            else{
                param.height=0
            }
            view.findViewById<TextView>(R.id.textUrgence2).layoutParams=param
        }


        var bottomSheet:View=activity!!.findViewById(R.id.bottom_sheet)
        val behavior =BottomSheetBehavior.from(bottomSheet)
/*Bouton services*/
        bottomSheet.findViewById<LinearLayout>(R.id.service).setOnClickListener {
            findNavController().navigate(R.id.action_urgenceFragment_to_servicesFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Tailles autorisée*/
        bottomSheet.findViewById<LinearLayout>(R.id.peche).setOnClickListener {
            findNavController().navigate(R.id.action_urgenceFragment_to_taillesAutoriseeFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Documentation*/
        bottomSheet.findViewById<LinearLayout>(R.id.documentation).setOnClickListener {
            findNavController().navigate(R.id.action_urgenceFragment_to_documentationFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton parametre*/
        bottomSheet.findViewById<LinearLayout>(R.id.settings).setOnClickListener {
            findNavController().navigate(R.id.action_urgenceFragment_to_ParametreFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton A propos*/
        bottomSheet.findViewById<LinearLayout>(R.id.aPropos).setOnClickListener {
            findNavController().navigate(R.id.action_urgenceFragment_to_AProposFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Bouton Appels d'urgence*/
        bottomSheet.findViewById<LinearLayout>(R.id.urgence).setOnClickListener {
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
        /*Boucton croix*/
        bottomSheet.findViewById<LinearLayout>(R.id.back).setOnClickListener {
            findNavController().navigate(R.id.action_urgenceFragment_to_HorairesFragment)
            bottomSheet.post { behavior.state = BottomSheetBehavior.STATE_COLLAPSED }
        }
    }


    @SuppressLint("MissingPermission")
    private fun getLastLocation() {
        if (checkPermissions()) {
            if (isLocationEnabled()) {

                mFusedLocationClient.lastLocation.addOnCompleteListener(activity  as Activity) { task ->
                    requestNewLocationData()
                    var location: Location? = task.result
                    if (location == null) {
                        view?.findViewById<TextView>(R.id.latitude)?.text ="Latitude : Inconnue"
                        view?.findViewById<TextView>(R.id.longitude)?.text ="Longitude : Inconnue"
                    } else {
                        view?.findViewById<TextView>(R.id.latitude)?.text ="Latitude :"+ location.latitude.toString()
                        view?.findViewById<TextView>(R.id.longitude)?.text ="Longitude :"+ location.longitude.toString()
                    }
                }
            } else {
                Toast.makeText(activity, "Turn on location", Toast.LENGTH_LONG).show()
                val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
                startActivity(intent)
            }
        } else {
            requestPermissions()
        }
    }

    @SuppressLint("MissingPermission")
    private fun requestNewLocationData() {
        var mLocationRequest = LocationRequest()
        mLocationRequest.priority = LocationRequest.PRIORITY_HIGH_ACCURACY
        mLocationRequest.interval = 0
        mLocationRequest.fastestInterval = 0
        mLocationRequest.numUpdates = 1

        mFusedLocationClient = LocationServices.getFusedLocationProviderClient(activity  as Activity)
    }

   /* private val mLocationCallback = object : LocationCallback() {
        override fun onLocationResult(locationResult: LocationResult) {
            view?.findViewById<TextView>(R.id.latitude)?.text ="Latitude : Inconnue"
            view?.findViewById<TextView>(R.id.longitude)?.text ="Longitude : Inconnue"
        }
    }*/

    private fun checkPermissions(): Boolean {
        if (ActivityCompat.checkSelfPermission(activity as Activity, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED &&
            ActivityCompat.checkSelfPermission(activity as Activity, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED){
            return true
        }
        return false
    }

    private fun requestPermissions() {
        ActivityCompat.requestPermissions(
            activity  as Activity,
            arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION, Manifest.permission.ACCESS_FINE_LOCATION), PERMISSION_ID)
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<String>, grantResults: IntArray) {
        if (requestCode == PERMISSION_ID) {
            if ((grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED)) {
            }
        }
    }

    private fun isLocationEnabled(): Boolean {
        var locationManager: LocationManager = activity?.getSystemService(Context.LOCATION_SERVICE) as LocationManager
        return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER) || locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
    }

}