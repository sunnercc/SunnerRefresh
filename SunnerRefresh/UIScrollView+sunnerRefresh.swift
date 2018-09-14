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
    
    public var sunnerRefreshHeader: SunnerRefreshHeader? {
        get {
            return objc_getAssociatedObject(self, &sunnerRefreshHeaderKey) as? SunnerRefreshHeader
        }
        set {
            objc_setAssociatedObject(self, &sunnerRefreshHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var sunnerRefreshFooter: SunnerRefreshFooter? {
        get {
            return objc_getAssociatedObject(self, &sunnerRefreshFooterKey) as? SunnerRefreshFooter
        }
        set {
            objc_setAssociatedObject(self, &sunnerRefreshFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIScrollView {
    
    public var sunner_insetT: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return self.adjustedContentInset.top
            } else {
                return self.contentInset.top
            }
        }
    }
    
    public var sunner_insetB: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return self.adjustedContentInset.bottom
            } else {
                return self.contentInset.bottom
            }
        }
    }
    
    public var sunner_insetL: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return self.adjustedContentInset.left
            } else {
                return self.contentInset.left
            }
        }
    }
    
    public var sunner_insetR: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return self.adjustedContentInset.right
            } else {
                return self.contentInset.right
            }
        }
    }
    
}
