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
    var scrollview: UIScrollView?
    
    fileprivate var _state: SunnerRefreshState = .idle
    var state: SunnerRefreshState {
        set {
            _state = newValue
            if _state == .will || _state == .refreshing {
                self.isHidden = false
            } else {
                self.isHidden = true
            }
        }
        get {
            return _state
        }
    }
    
    
    public convenience init(inView: UIScrollView) {
        self.init(frame: .zero)
        self.scrollview = inView
        self.addObservers()
        self.addSelf()
        self.addSelfChilds()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.removeObservers()
        self.removeSelf()
    }
    
    public override func layoutSubviews() {
        if self.frame.equalTo(.zero) {
            let rect = self.layoutFrame(scrollview: self.scrollview!)
            let convertRect = convert(rect, to: self.scrollview?.superview)
            self.frame = convertRect
        } else {
            self.layoutSelfChildsFrames()
        }
    }
    
    public func layoutFrame(scrollview: UIScrollView) -> CGRect {
        return .zero
        
    }
    public func refreshObserveValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

    }
    
    public func beginRefresh() {
        self.loadRefreshTask()
    }
    
    public func endRefresh() {
        
    }
    
    public func addSelfChilds() {
        
    }
    
    public func layoutSelfChildsFrames() {
        
    }
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
    
    fileprivate func addSelf() {
        self.scrollview?.superview?.addSubview(self)
    }
    
    fileprivate func removeSelf() {
        self.removeFromSuperview()
    }
}
