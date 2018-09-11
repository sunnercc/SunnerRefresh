//
//  UIScrollView+sunnerRefresh.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

var sunnerRefreshHeaderKey = "sunnerRefreshHeaderKey"
var sunnerRefreshFooterKey = "sunnerRefreshFooterKey"

extension UIScrollView {
    
    open var sunnerRefreshHeader: SunnerRefreshHeader? {
        get {
            if let header = objc_getAssociatedObject(self, &sunnerRefreshHeaderKey) as? SunnerRefreshHeader {
                return header
            }
            return nil
        }
        set {
            if self.sunnerRefreshHeader != newValue {
                self.sunnerRefreshHeader?.removeFromSuperview()
                objc_setAssociatedObject(self, &sunnerRefreshHeaderKey, nil, .OBJC_ASSOCIATION_RETAIN)
                
                if let newValue = newValue {
                    self.insertSubview(newValue, at: 0)
                    objc_setAssociatedObject(self, &sunnerRefreshHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
                }
            }
        }
    }
    
    open var sunnerRefreshFooter: SunnerRefreshFooter? {
        get {
            if let footer = objc_getAssociatedObject(self, &sunnerRefreshFooterKey) as? SunnerRefreshFooter {
                return footer
            }
            return nil
        }
        set {
            if self.sunnerRefreshFooter != newValue {
                self.sunnerRefreshFooter?.removeFromSuperview()
                objc_setAssociatedObject(self, &sunnerRefreshFooterKey, nil, .OBJC_ASSOCIATION_RETAIN)
                
                if let newValue = newValue {
                    self.insertSubview(newValue, at: 0)
                    objc_setAssociatedObject(self, &sunnerRefreshFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
                }
            }
        }
    }
}