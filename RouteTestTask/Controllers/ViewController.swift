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
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var resetButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Reset"), for: .normal)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var annotationsArray = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }

    private func setupViews() {
        view.addSubview(mapView)
        view.addSubview(addAddressButton)
        view.addSubview(routeButton)
        view.addSubview(resetButton)
    }
    
    @objc func addAddressButtonTapped() {
        alertAddAddress(title: "Add", placeholder: "Enter address") { [weak self] (text) in
            self?.setupPlacemark(addressPlace: text)
        }
    }
    
    @objc func routeButtonTapped() {
        print("routeButtonTapped")
    }
    
    @objc func resetButtonTapped() {
        print("resetButtonTapped")
    }
    
    private func setupPlacemark(addressPlace: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressPlace) { [weak self] placemarks, error in
            
            if let error = error {
                print(error.localizedDescription)
                self?.alertError(title: "Ошибка", message: "Сервер недоступен. Попробуйте добавить адрес еще раз")
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = addressPlace
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            self?.annotationsArray.append(annotation)
            
            if self?.annotationsArray.count ?? 0 > 2 {
                self?.resetButton.isHidden = false
                self?.routeButton.isHidden = false
            }
            
            self?.mapView.showAnnotations(self!.annotationsArray, animated: true)
        }
    }
    
    private func getShortestDirection(directionRequest: MKDirections.Request) {
        let direction = MKDirections(request: directionRequest)
        direction.calculate { [weak self] (response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response else {
                self?.alertError(title: "Ошибка", message: "Маршрут недоступен")
                return
            }
            
            var minRoute = response.routes.sorted{ $0.distance < $1.distance }.first
            if let overlay = minRoute?.polyline as? MKOverlay {
                self?.mapView.addOverlay(overlay)
            }
        }
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
            
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
