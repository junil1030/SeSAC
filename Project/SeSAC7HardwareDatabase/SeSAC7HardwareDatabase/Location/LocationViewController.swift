//
//  LocationViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/9/25.
//

import UIKit
import MapKit
import CoreLocation // 1. 프레임워크
import SnapKit

class LocationViewController: UIViewController {
    
    private let mapView = MKMapView()
    // 2. 위치 매니저 생성: 위치에 대한 대부분을 담당
    private lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        configure()
    }
    
    private let button = UIButton()
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(button.snp.top)
        }
        
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    // 1. iOS 위치 서비스 활성화 여부 확인
    @objc private func buttonClicked() {
        
        DispatchQueue.global().async {
            
            if CLLocationManager.locationServicesEnabled() {
                print("권한 허용 가능한 상태")
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAlert()
                }
                
            } else {
                print("위치 서비스가 꺼져있어서 위치 권한 요청을 할 수 없습니다.")
            }

        }
    }
    
    // 2. 현재 사용자 권한 상태 확인 후 얼럿 띄우기 / 항상 얼럿이 뜨는 건 아님
    func checkCurrentLocationAlert() {
        
        var status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            print("권한이 아직 결정되지 않은 상태로, 여기서만 권한 문구를 띄울 수 있음.")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("사용자가 거부한 상황, iOS 설정 창으로 이동하라는 얼럿 띄우기")
        case .authorizedWhenInUse:
            print("사용자가 허용한 상태이기 때문에 위치 정보를 얻어오는 로직을 구성할 수 있음")
            // didUpdateLocations를 실행시켜 줄 수 있음
            locationManager.startUpdatingLocation()
        default:
            print(status)
        }
        
    }
}

// 3. 위치 프로토콜
extension LocationViewController: CLLocationManagerDelegate {
    
    // didUpdateLocations 위치를 성공적으로 조회한 경우
    // 코드 구성에 따라서 여러 번 호출이 될 수도 있다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        guard let locationsCoordinate = locations.first?.coordinate else { return }
        print(locationsCoordinate)
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: locationsCoordinate.latitude, longitude: locationsCoordinate.longitude),
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )
        mapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
    }
    
    // didFailWithError 위치 조회를 실패한 경우 (권한이 없을 때)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    // 사용자 권한 상태가 변경된 경우 (iOS 14 이상)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
    
    // 사용자 권한 상태가 변경된 경우 (iOS 14 미만)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}
