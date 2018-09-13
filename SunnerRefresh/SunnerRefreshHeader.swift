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
    var state: SunnerRefreshState = .idle
    var offset: CGPoint = .zero
    
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
        print(Thread.current)
        if let object = object as? NSObject,
            let keyPath = keyPath {
            if object.isEqual(self.scrollview) && keyPath == sunnerRefreshScrollviewContentOffsetKeyPath
            {
                let offsetY = (self.scrollview?.contentOffset.y)!
                let insetT = (self.scrollview?.sunner_insetT)!
                let dis = offsetY + insetT
                if dis >= 0
                {
                    self.state = .idle
                }
                else if dis < 0 && dis >= -sunnerRefreshHeaderHeight
                {
                    self.state = .drag
                }
                else if dis < -sunnerRefreshHeaderHeight
                {
                    self.state = .will
                }
            }
            if object.isEqual(self.scrollview) && keyPath == sunnerRefreshScrollviewContentSizeKeyPath
            {
                
            }
            if object.isEqual(self.scrollview?.panGestureRecognizer) && keyPath == sunnerRefreshScrollviewPanGesStateKeyPath
            {
                if self.scrollview?.panGestureRecognizer.state == UIGestureRecognizerState.ended {
                    if self.state == .refreshing {
                        return
                    }
                    else if self.state == .will {
                        self.beginRefresh()
                    }
                }
            }
        }
    }
}

extension SunnerRefreshHeader {
    
    public func beginRefresh() {
        DispatchQueue.main.async {
            self.state = .refreshing
            let y = -(self.scrollview?.sunner_insetT)!-sunnerRefreshHeaderHeight
            let offset = CGPoint(x: (self.scrollview?.contentOffset.x)!, y: y)
            self.scrollview?.setContentOffset(offset, animated: true)
            self.loadRefreshTask()
        }
    }
    
    public func endRefresh() {
        DispatchQueue.main.async {
            let y = -(self.scrollview?.sunner_insetT)!
            let offset = CGPoint(x: (self.scrollview?.contentOffset.x)!, y: y)
            self.scrollview?.setContentOffset(offset, animated: true)
        }
    }
    
    fileprivate func loadRefreshTask() {
        if let target = self.target, let action = self.action {
            target.perform(action)
        }
    }
}
