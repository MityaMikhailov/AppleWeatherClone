//
//  LoadView.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 15.07.2024.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Место"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "_ _"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loadStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.addArrangedSubview(locationLabel)
        stack.addArrangedSubview(temperatureLabel)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLoadStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup UI
    private func setupUI() {
        self.backgroundColor = .clear
    }
    //MARK: - Setup Load Stack
    private func setupLoadStack() {
        self.addSubview(loadStack)
        loadStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.snp.makeConstraints {
            $0.height.equalTo(loadStack.snp.height)
        }
    }
}
