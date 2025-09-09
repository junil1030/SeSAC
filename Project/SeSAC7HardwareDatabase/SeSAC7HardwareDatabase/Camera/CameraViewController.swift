//
//  CameraViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/9/25.
//

import UIKit
import Photos

/*
 시뮬레이터로 카메라 촬영 불가 / 맥북캠 사용 안됨
 캠이 없는 아이폰이 있을 수도 있음
 
 1. 촬영을 할 수 있음
 2. 갤러리에서 사진을 가져올 수 있음
 3. 사진을 갤러리에 저장할 수 있음
 -> iOS13까지는 UIImagePickerController (시스템UI) (현재는 1번만 담당을하고)
    -> 갤러리에서 여러 장 선택하는 것이 불가능sadfjidfdfㅑ
 -> iOS14부터는 PHPicker(out of process)가 등장 (2, 3번은 요놈이 담당)
 */

class CameraViewController: UIViewController {
    
    let manager = UIImagePickerController()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        imageView.backgroundColor = .lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        manager.sourceType = .camera // 카메라로 사용
        manager.allowsEditing = true // 간단한 편집
        
        present(manager, animated: true)
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        let image = info[.editedImage] as? UIImage
        
        if let image = image {
            print("이미지 있음")
            imageView.image = image
        } else {
            print("잘못된 이미지")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
}
