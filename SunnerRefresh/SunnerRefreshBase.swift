//
//  SunnerRefreshBase.swift
//  SunnerRefresh
//
//  Created by ifuwo on 2018/9/13.
//  Copyright © 2018年 sunner. All rights reserved.
//

import UIKit

public class SunnerRefreshBase: UIView {

    var target: NSObject? = nil
    var action: Selector? = nil
    var scrollview: UIScrollView? = nil
    var state: SunnerRefreshState = .idle
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ///
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    public func layoutSize() {}
    public func refreshObserveValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {}
    public func beginRefresh() {
        self.loadRefreshTask()
    }
    public func endRefresh() {}
}


extension SunnerRefreshBase {
    
    public func refreshing(target: NSObject, action: Selector) {
        self.target = target
        self.action = action
    }
    
    fileprivate func loadRefreshTask() {
        if let target = self.target, let action = self.action {
            target.perform(action)
        }
    }
}

extension SunnerRefreshBase {
    
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
        self.refreshObserveValue(forKeyPath: keyPath, of: object, change: change, context: context)
    }
}
