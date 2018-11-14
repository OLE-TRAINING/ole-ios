//
//  CustomBar.swift
//  LocadoraOleTraining
//
//  Created by Lorena Rodrigues Bruno on 06/11/2018.
//  Copyright © 2018 Lorena Rodrigues Bruno. All rights reserved.
//

import Foundation
import Tabman
import Pageboy

class CustomBar: TabmanBar {
    override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .line
    }
    
    override func usePreferredIndicatorStyle() -> Bool {
        // whether the bar should use preferredIndicatorStyle
        return true
    }
    
    override func construct(in contentView: UIView,
                            for items: [TabmanBar.Item]) {
        // create your bar here
    }
    
    override func add(indicator: TabmanIndicator, to contentView: UIView) {
        // add the indicator to the bar here
    }
    
    override func update(forPosition position: CGFloat,
                         direction: PageboyViewController.NavigationDirection,
                         indexRange: Range<Int>,
                         bounds: CGRect) {
        super.update(forPosition: position, direction: direction,
                     indexRange: indexRange,
                     bounds: bounds)
        
        // update your bar contents for a positional update here
    }
    
    override func update(forAppearance appearance: Appearance,
                         defaultAppearance: Appearance) {
        super.update(forAppearance: appearance,
                     defaultAppearance: defaultAppearance)
        
        // update the bar appearance here
    }
}
