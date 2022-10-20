//
//  ViewController.swift
//  RouteTestTask
//
//  Created by Zenya Kirilov on 18.10.22.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    lazy var addAddressButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "AddAddress"), for: .normal)
        button.addTarget(self, action: #selector(addAddressButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var routeButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Route"), for: .normal)
        button.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }

    private func setupViews() {
        view.addSubview(mapView)
        view.addSubview(addAddressButton)
        view.addSubview(routeButton)
    }
    
    @objc func addAddressButtonTapped() {
        print("addAddressButtonTapped")
    }
    
    @objc func routeButtonTapped() {
        print("routeButtonTapped")
    }

}

extension ViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            addAddressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAddressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAddressButton.widthAnchor.constraint(equalToConstant: 100),
            addAddressButton.heightAnchor.constraint(equalToConstant: 100),
            
            routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            routeButton.widthAnchor.constraint(equalToConstant: 100),
            routeButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
}
