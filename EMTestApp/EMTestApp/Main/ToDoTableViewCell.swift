//
//  ToDoTableViewCell.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    var onStatusTapped: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toDoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "none"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        contentView.backgroundColor = .black
        setupLayout()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        contentView.addSubview(statusImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(toDoTextView)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            statusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statusImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            statusImageView.heightAnchor.constraint(equalToConstant: 24),
            statusImageView.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            toDoTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            toDoTextView.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 5),
            toDoTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: toDoTextView.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Gesture
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(statusTapped))
        statusImageView.addGestureRecognizer(tap)
    }
    
    @objc private func statusTapped() {
        onStatusTapped?()
    }
    
    // MARK: - Configure
    
    func configure(toDoText: String, isCompleted: Bool, index: Int, creationDate: Date?) {
        let title = "Новая задача \(index)"
        let attributes: [NSAttributedString.Key: Any] = isCompleted
            ? [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            : [:]
        
        titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        
        let dateToShow: String
        if let date = creationDate {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"
            dateToShow = formatter.string(from: date)
        } else {
            dateToShow = "30/10/25"
        }
        
        dateLabel.text = dateToShow
        statusImageView.image = isCompleted ? UIImage(named: "done") : UIImage(named: "none")
        toDoTextView.text = toDoText
        
        dateLabel.textColor = isCompleted ? .systemGray : .white
        titleLabel.textColor = isCompleted ? .systemGray : .white
        toDoTextView.textColor = isCompleted ? .systemGray : .white
    }
}
