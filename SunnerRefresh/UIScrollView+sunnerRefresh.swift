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
            if let header = objc_getAssociatedObject(self, &sunnerRefreshHeaderKey) as? SunnerRefreshHeader {
                return header
            }
            return nil
        }
        set {
            if self.sunnerRefreshHeader != newValue {
                self.sunnerRefreshHeader?.removeFromSuperview()
                objc_setAssociatedObject(self, &sunnerRefreshHeaderKey, nil, .OBJC_ASSOCIATION_ASSIGN)
                
                if let newValue = newValue {
                    // sunnerRefreshHeader被insertSubview后, 不需要retain
                    self.insertSubview(newValue, at: 0)
                    objc_setAssociatedObject(self, &sunnerRefreshHeaderKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
                }
            }
        }
    }
    
    public var sunnerRefreshFooter: SunnerRefreshFooter? {
        get {
            if let footer = objc_getAssociatedObject(self, &sunnerRefreshFooterKey) as? SunnerRefreshFooter {
                return footer
            }
            return nil
        }
        set {
            if self.sunnerRefreshFooter != newValue {
                self.sunnerRefreshFooter?.removeFromSuperview()
                objc_setAssociatedObject(self, &sunnerRefreshFooterKey, nil, .OBJC_ASSOCIATION_ASSIGN)
                
                if let newValue = newValue {
                    // sunnerRefreshFooter被insertSubview后, 不需要retain
                    self.insertSubview(newValue, at: 0)
                    objc_setAssociatedObject(self, &sunnerRefreshFooterKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
                }
            }
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
