//
//  File.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/19/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

extension UIView {
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {
            return nil
        }
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoPinEdgesToSuperviewEdges()
        return view
    }
}
