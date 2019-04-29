//
//  CreateCarViewController.swift
//  CarCatalog
//
//  Created by Artyom Burkan on 28/04/2019.
//  Copyright © 2019 Artyom Burkan. All rights reserved.
//

import UIKit

enum Action {
    case create
    case edit(car: Car, index: Int)
    
    var title: String {
        switch self {
        case .create:
            return "Создать"
        case .edit:
            return "Редактировать"
        }
    }
}

protocol CreateCarDelegate: class {
    func onCreate(car: Car)
    func onEdit(car: Car, index: Int)
}

class CreateCarViewController: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    weak var delegate: CreateCarDelegate?
    
    let releaseYearTextView = UITextField()
    let modelTextView = UITextField()
    let producerTextView = UITextField()
    let classTypeTextView = UITextField()
    let bodyTypeTextView = UITextField()
    let button = UIButton()
    
    let action: Action
    
    init(action: Action) {
        self.action = action
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = action.title
        
        if case .edit(let car, _) = action {
            releaseYearTextView.text = car.releaseYear
            modelTextView.text = car.model
            producerTextView.text = car.producer
            classTypeTextView.text = car.classType
            bodyTypeTextView.text = car.bodyType
        }
        
        // StackView
        stackView.axis = .vertical
        stackView.spacing = 10
        
        layout(releaseYearTextView)
        customize(releaseYearTextView, "Введите год")
        
        layout(modelTextView)
        customize(modelTextView, "Введите модель")
        
        layout(producerTextView)
        customize(producerTextView, "Введите производителя")
        
        layout(classTypeTextView)
        customize(classTypeTextView, "Введите класс")
        
        layout(bodyTypeTextView)
        customize(bodyTypeTextView, "Введите тип кузова")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена",
                                                            style: UIBarButtonItem.Style.plain,
                                                            target: self,
                                                            action: #selector(dismissViewController))
            
        // ScrollView
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.trailing.bottom.leading.equalToSuperview()
        }
        // scrollView.backgroundColor = UIColor.green
        view.backgroundColor = UIColor.white

        // StackView
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(releaseYearTextView)
        stackView.addArrangedSubview(modelTextView)
        stackView.addArrangedSubview(producerTextView)
        stackView.addArrangedSubview(classTypeTextView)
        stackView.addArrangedSubview(bodyTypeTextView)
        
        button.setTitle(action.title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(saveCar), for: .touchUpInside)
        stackView.addArrangedSubview(button)
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(-16)
            $0.bottom.equalToSuperview().inset(-16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalToSuperview().offset(-32)
        }
        
        
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    func customize(_ textField: UITextField, _ placeHolder: String) {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.placeholder = placeHolder

        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
    }
    
    func layout(_ textField: UITextField) {
        textField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
    
    @objc func saveCar() {
        let car = Car(
            releaseYear: releaseYearTextView.text ?? "",
            model: modelTextView.text ?? "",
            producer: producerTextView.text ?? "",
            classType: classTypeTextView.text ?? "",
            bodyType: bodyTypeTextView.text ?? ""
        )
        
        switch action {
        case .create:
             delegate?.onCreate(car: car)
        case .edit(_, let index):
            delegate?.onEdit(car: car, index: index)
        }
        
        dismiss(animated: true, completion: nil)
    }
}



extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
