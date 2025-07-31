//
//  DetailViewController.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 7/31/25.
//

import UIKit

class DetailViewController: UIViewController {

    let field = UITextField()
    
    var content: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(field)
        
        field.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }

        field.placeholder = "입력해보세요"
//        field.placeholder = content
        
        view.backgroundColor = .lightGray
        navigationItem.title = "디테일 화면"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        
        // responder chain
        field.becomeFirstResponder()
    }
    
    @objc func leftBarButtonClicked() {
        print(#function)
        
        content?(field.text!)
        
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
