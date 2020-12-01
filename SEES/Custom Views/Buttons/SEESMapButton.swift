//
//  SEESMapButton.swift
//  SEES
//
//  Created by Robert Parsons on 11/30/20.
//

import UIKit
import MapKit

class SEESMapButton: UIButton {
    let mapSnapshotOptions = MKMapSnapshotter.Options()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        layer.cornerRadius = 14
        backgroundColor = .systemBlue
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func conifugreSnapshotter() {
        
    }
    
    @objc func buttonTapped() {
        print("Tapped")
    }
}
