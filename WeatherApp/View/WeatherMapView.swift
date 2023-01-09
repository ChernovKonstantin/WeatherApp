//
//  WeatherMapView.swift
//  WeatherApp
//
//  Created by Chernov Kostiantyn on 05.01.2023.
//

import SwiftUI
import MapKit

struct WeatherMapView: UIViewRepresentable {
    
    @Binding var location: CLLocation?
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        guard let location else { return }
        let span = MKCoordinateSpan(latitudeDelta: 4, longitudeDelta: 4)
        var lastCoordinate = CLLocationCoordinate2D()
        lastCoordinate.latitude = location.coordinate.latitude
        lastCoordinate.longitude = location.coordinate.longitude
        let region = MKCoordinateRegion(center: lastCoordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let myMap = MKMapView(frame: .zero)
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(EntireMapViewCoordinator.addAnnotation(gesture:)))
        longPress.minimumPressDuration = 0.3
        myMap.addGestureRecognizer(longPress)
        myMap.delegate = context.coordinator
        return myMap
        
    }
    
    func makeCoordinator() -> EntireMapViewCoordinator {
        return EntireMapViewCoordinator(self)
    }
    
    class EntireMapViewCoordinator: NSObject, MKMapViewDelegate {
        
        var entireMapViewController: WeatherMapView
        
        init(_ control: WeatherMapView) {
            self.entireMapViewController = control
        }
        
        
        @objc func addAnnotation(gesture: UIGestureRecognizer) {
            
            if gesture.state == .ended {
                if let mapView = gesture.view as? MKMapView {
                    let point = gesture.location(in: mapView)
                    let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                    entireMapViewController.location = CLLocation(latitude: coordinate.latitude,
                                                                  longitude: coordinate.longitude)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    mapView.removeAnnotations(mapView.annotations)
                    mapView.addAnnotation(annotation)
                }
            }
        }
    }
}
