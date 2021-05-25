//
//  UIColorExtensions.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 4/23/21.
//

import UIKit

extension UIColor {
    enum SystemHue: CGFloat {
        case red = 0.008333333333333
        case green = 0.375
    }
    
    func withRedHue(saturation: CGFloat = 0.6) -> UIColor {
        return self.modified(newHue: SystemHue.red.rawValue, additionalSaturation: saturation)
    }
    
    func withGreenHue(saturation: CGFloat = 0.6) -> UIColor {
        return self.modified(newHue: SystemHue.green.rawValue, additionalSaturation: saturation)
    }
    
    func modified(newHue: CGFloat = 0, additionalSaturation: CGFloat = 0, additionalBrightness: CGFloat = 0) -> UIColor {
        var currentHue: CGFloat = 0.0
        var currentSaturation: CGFloat = 0.0
        var currentBrigthness: CGFloat = 0.0
        var currentAlpha: CGFloat = 0.0

        if self.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha){
            return UIColor(hue: newHue,
                           saturation: currentSaturation + additionalSaturation,
                           brightness: currentBrigthness + additionalBrightness,
                           alpha: currentAlpha)
        } else {
            return self
        }
    }
}
