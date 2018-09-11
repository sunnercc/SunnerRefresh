//
//  UIView+SunnerExtension.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

extension UIView {
    
    open var sunner_x: CGFloat {
        set {
            self.frame.origin.x = newValue
        }
        get {
            return self.frame.origin.x
        }
    }
    
    open var sunner_y: CGFloat {
        set {
            self.frame.origin.y = newValue
        }
        get {
            return self.frame.origin.y
        }
    }
    
    open var sunner_w: CGFloat {
        set {
            self.frame.size.width = newValue
        }
        get {
            return self.frame.size.width
        }
    }
    
    open var sunner_h: CGFloat {
        set {
            self.frame.size.height = newValue
        }
        get {
            return self.frame.size.height
        }
    }
    
}
