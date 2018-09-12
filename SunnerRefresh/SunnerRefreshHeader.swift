//
//  SunnerRefreshHeader.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/11.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

public class SunnerRefreshHeader: UIView {
    
    var target: NSObject? = nil
    var action: Selector? = nil
    var scrollview: UIScrollView? = nil
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        //
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let newSuperview = newSuperview {
            if newSuperview.isKind(of: UIScrollView.classForCoder()) {
                self.removeObservers()
                self.scrollview = newSuperview as? UIScrollView
                self.addObservers()
                self.layoutSize()
            }
        }
        else
        {
            self.removeObservers()
            self.scrollview = nil
        }
    }
}

extension SunnerRefreshHeader : RefreshProtocol {
    
    public func refreshing(target: NSObject, action: Selector) {
        self.target = target
        self.action = action
    }
}

extension SunnerRefreshHeader {
    
    fileprivate func layoutSize() {
        self.sunner_w = (self.scrollview?.frame.size.width)!
        self.sunner_h = sunnerRefreshHeaderHeight
        self.sunner_x = 0
        self.sunner_y = -self.sunner_h
    }
}

extension SunnerRefreshHeader {
    
    fileprivate func addObservers() {
        self.scrollview?.addObserver(self, forKeyPath: sunnerRefreshScrollviewContentOffsetKeyPath, options: .new, context: nil)
        self.scrollview?.addObserver(self, forKeyPath: sunnerRefreshScrollviewContentSizeKeyPath, options: .new, context: nil)
        self.scrollview?.panGestureRecognizer.addObserver(self, forKeyPath: sunnerRefreshScrollviewPanGesStateKeyPath, options: .new, context: nil)
    }
    
    fileprivate func removeObservers() {
        self.scrollview?.removeObserver(self, forKeyPath: sunnerRefreshScrollviewContentOffsetKeyPath)
        self.scrollview?.removeObserver(self, forKeyPath: sunnerRefreshScrollviewContentSizeKeyPath)
        self.scrollview?.panGestureRecognizer.removeObserver(self, forKeyPath: sunnerRefreshScrollviewPanGesStateKeyPath)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let object = object as? NSObject,
            let keyPath = keyPath {
            if object.isEqual(self.scrollview) && keyPath == sunnerRefreshScrollviewContentOffsetKeyPath
            {
                let offsetY = (self.scrollview?.contentOffset.y)!
                let insetT = (self.scrollview?.sunner_insetT)!
                let dis = offsetY + insetT
                if dis >= 0
                {
                    // header未显示
                }
                else if dis < 0 && dis > -sunnerRefreshHeaderHeight
                {
                    // header显示一部分
                    print("refresh")
                }
                else if dis <= -sunnerRefreshHeaderHeight
                {
                    // header完全显示
                    print("refreshing")
                }
            }
            if object.isEqual(self.scrollview) && keyPath == sunnerRefreshScrollviewContentSizeKeyPath
            {
                
            }
            if object.isEqual(self.scrollview?.panGestureRecognizer) && keyPath == sunnerRefreshScrollviewPanGesStateKeyPath
            {
                
            }
        }
    }
}
