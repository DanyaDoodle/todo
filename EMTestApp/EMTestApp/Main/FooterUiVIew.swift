//
//  FooterUiVIew.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 26.10.2025.
//

import UIKit

protocol FooterViewDelegate: AnyObject {
    func didTapAddToDo()
}

final class FooterView: UIView {
    
    // MARK: - Property
    
    weak var delegate: FooterViewDelegate?
    
    private let toDoCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.9960784314, green: 0.8431372549, blue: 0.007843137255, alpha: 1)
        button.addTarget(self, action: #selector(addToDoItem), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    // MARK: - Public
    
    func footerConfigure(with count: Int) {
        toDoCountLabel.text = "\(count) задач"
    }
    
    // MARK: - Setup
    
    private func setupConstraints() {
        addSubview(toDoCountLabel)
        addSubview(editButton)
        
        NSLayoutConstraint.activate([
            toDoCountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            toDoCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            editButton.centerYAnchor.constraint(equalTo: toDoCountLabel.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            editButton.heightAnchor.constraint(equalToConstant: 24),
            editButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc
    private func addToDoItem() {
        delegate?.didTapAddToDo()
    }

}

