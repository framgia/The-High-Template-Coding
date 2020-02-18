//
//  UITableViewSmart.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

// MARK: - TableView
class UITableViewSmart: UITableView {
    
    override var frame: CGRect {
        willSet(newValue) {
            if newValue.equalTo(frame) {
                return
            }
            super.frame = frame
        }
        didSet {
            if hasAutomaticKeyboardAvoidingBehaviour() {return}
            updateContentInset()
        }
    }
    
    override var contentSize: CGSize {
        willSet(newValue) {
            if newValue.equalTo(contentSize) {
                return
            }
            if hasAutomaticKeyboardAvoidingBehaviour() {
                super.contentSize = newValue
                return
            }
            super.contentSize = newValue
        }
        didSet {
            updateContentInset()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        registerObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerObserver()
    }
    
    override func awakeFromNib() {
        registerObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            cancelPerform()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyBoard()
        super.touchesEnded(touches, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        callPerform()
    }
}

extension UITableViewSmart: UITextFieldDelegate {
    
    fileprivate func cancelPerform() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(assignTextDelegateForViewsBeneathView(_:)), object: self)
    }
    
    fileprivate func callPerform() {
        cancelPerform()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(assignTextDelegateForViewsBeneathView(_:)), userInfo: nil, repeats: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !focusNextTextField() {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UITableViewSmart: UITextViewDelegate {
    
}

extension UITableViewSmart {
    
    fileprivate func hideKeyBoard() {
        findFirstResponderBeneathView(self)?.resignFirstResponder()
    }
    
    fileprivate func hasAutomaticKeyboardAvoidingBehaviour() -> Bool {
        if #available(iOS 8.3, *) {
            if self.delegate is UITableViewController {
                return true
            }
        }
        return false
    }
    
    fileprivate func focusNextTextField() -> Bool {
        return keyboard_focusNextTextField()
    }
    
    fileprivate func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func registerObserver() {
        if hasAutomaticKeyboardAvoidingBehaviour() { return }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: UITextView.textDidBeginEditingNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: UITextField.textDidBeginEditingNotification,
                                               object: nil)
    }
}

// MARK: - CollectionView
class UICollectionViewSmart: UICollectionView {
    
    override var contentSize: CGSize {
        willSet(newValue) {
            if newValue.equalTo(contentSize) {
                return
            }
            super.contentSize = newValue
            updateContentInset()
        }
    }
    
    override var frame: CGRect {
        willSet(newValue) {
            if newValue.equalTo(self.frame) {
                return
            }
            super.frame = frame
            updateContentInset()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        registerObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerObserver()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            cancelPerform()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyBoard()
        super.touchesEnded(touches, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        callPerform()
    }
}

extension UICollectionViewSmart: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !focusNextTextField() {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UICollectionViewSmart: UITextViewDelegate {
    
}

extension UICollectionViewSmart {
    
    fileprivate func cancelPerform() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(assignTextDelegateForViewsBeneathView(_:)), object: self)
    }
    
    fileprivate func callPerform() {
        cancelPerform()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(assignTextDelegateForViewsBeneathView(_:)), userInfo: nil, repeats: false)
    }
    
    fileprivate func hideKeyBoard() {
        findFirstResponderBeneathView(self)?.resignFirstResponder()
    }
    
    fileprivate func focusNextTextField() -> Bool {
        return keyboard_focusNextTextField()
    }
    
    fileprivate func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func registerObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: UITextView.textDidBeginEditingNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: UITextField.textDidBeginEditingNotification,
                                               object: nil)
    }
}

// MARK: - ScrollView
class UIScrollViewSmart: UIScrollView {
    
    // MARK: - Property
    override var contentSize: CGSize {
        willSet(newValue) {
            if newValue.equalTo(contentSize) {
                return
            }
            super.contentSize = newValue
            updateFromContentSizeChange()
        }
    }
    
    override var frame: CGRect {
        willSet(newValue) {
            if newValue.equalTo(frame) {
                return
            }
            super.frame = newValue
            updateContentInset()
        }
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        registerObserver()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    // MARK: - Override
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            cancelPerform()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyBoard()
        super.touchesEnded(touches, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        callPerform()
    }
}

// MARK: - Extension
extension UIScrollViewSmart: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !focusNextTextField() {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension UIScrollViewSmart: UITextViewDelegate {
    // TO DO
}

extension UIScrollViewSmart {
    
    fileprivate func cancelPerform() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(assignTextDelegateForViewsBeneathView(_:)), object: self)
    }
    
    /// register Delegate
    fileprivate func callPerform() { /// when call -> cancel
        cancelPerform()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(assignTextDelegateForViewsBeneathView(_:)), userInfo: nil, repeats: false)
    }
    
    fileprivate func hideKeyBoard() {
        findFirstResponderBeneathView(self)?.resignFirstResponder()
    }
    
    fileprivate func contentSizeToFit() {
        contentSize = calculatedContentSizeFromSubviewFrames()
    }
    
    fileprivate func focusNextTextField() -> Bool {
        return keyboard_focusNextTextField()
    }
    
    fileprivate func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func registerObserver() {
        /// UIKeyboardWillChangeFrame
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        /// UIKeyboardWillHide
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        /// UITextViewTextDidBeginEditing
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: UITextView.textDidBeginEditingNotification,
                                               object: nil)
        /// UITextFieldTextDidBeginEditing
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToActiveTextField),
                                               name: UITextField.textDidBeginEditingNotification,
                                               object: nil)
    }
}

// MARK: - Process Event
let kCalculatedContentPadding: CGFloat = 10
let kMinimumScrollOffsetPadding: CGFloat = 20

extension UIScrollView {
    
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let rectNotification = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardRect = convert(rectNotification.cgRectValue, from: nil)
        if keyboardRect.isEmpty {
            return
        }
        
        let state = keyboardState()
        guard let firstResponder = findFirstResponderBeneathView(self) else { return}
        state.keyboardRect = keyboardRect
        if !state.keyboardVisible {
            state.priorInset = contentInset
            state.priorScrollIndicatorInsets = scrollIndicatorInsets
            state.priorPagingEnabled = isPagingEnabled
        }
        
        state.keyboardVisible = true
        isPagingEnabled = false
        if self is UIScrollViewSmart {
            state.priorContentSize = contentSize
            if contentSize.equalTo(CGSize.zero) {
                contentSize = calculatedContentSizeFromSubviewFrames()
            }
        }
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Float ?? 0.0
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let options = UIView.AnimationOptions(rawValue: UInt(curve))
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options, animations: { [weak self]() -> Void in
            guard let strongSelf = self else {
                return
            }
            strongSelf.contentInset = strongSelf.contentInsetForKeyboard()
            let viewableHeight = strongSelf.bounds.size.height - (strongSelf.contentInset.top + strongSelf.contentInset.bottom)
            let point = CGPoint(x: strongSelf.contentOffset.x, y: strongSelf.idealOffsetForView(firstResponder, viewAreaHeight: viewableHeight))
            strongSelf.setContentOffset(point, animated: false)
            strongSelf.scrollIndicatorInsets = strongSelf.contentInset
            strongSelf.layoutIfNeeded()
        }) { (finished) -> Void in
        }
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let rectNotification = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardRect = convert(rectNotification.cgRectValue, from: nil)
        if keyboardRect.isEmpty {
            return
        }
        let state = keyboardState()
        if !state.keyboardVisible {
            return
        }
        state.keyboardRect = CGRect.zero
        state.keyboardVisible = false
        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Float ?? 0.0
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int ?? 0
        let options = UIView.AnimationOptions(rawValue: UInt(curve))
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: options, animations: { [weak self]() -> Void in
            guard let strongSelf = self else {
                return
            }
            if strongSelf is UIScrollViewSmart {
                strongSelf.contentSize = state.priorContentSize
                strongSelf.contentInset = state.priorInset
                strongSelf.scrollIndicatorInsets = state.priorScrollIndicatorInsets
                strongSelf.isPagingEnabled = state.priorPagingEnabled
                strongSelf.layoutIfNeeded()
            }
        }) { (finished) -> Void in
        }
    }
    
    fileprivate func updateFromContentSizeChange() {
        let state = keyboardState()
        if state.keyboardVisible {
            state.priorContentSize = contentSize
        }
    }
    
    fileprivate func keyboard_focusNextTextField() -> Bool {
        guard let firstResponder = findFirstResponderBeneathView(self) else { return false}
        guard let view = findNextInputViewAfterView(firstResponder, beneathView: self) else { return false}
        Timer.scheduledTimer(timeInterval: 0.1, target: view, selector: #selector(becomeFirstResponder), userInfo: nil, repeats: false)
        return true
    }
    
    @objc fileprivate func scrollToActiveTextField() {
        let state = keyboardState()
        if !state.keyboardVisible { return }
        let visibleSpace = bounds.size.height - (contentInset.top + contentInset.bottom)
        let y = idealOffsetForView(findFirstResponderBeneathView(self), viewAreaHeight: visibleSpace)
        let idealOffset = CGPoint(x: 0, y: y)
        DispatchQueue.main.asyncAfter(deadline: .now() + Double((Int64)(0 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {[weak self] () -> Void in
            self?.setContentOffset(idealOffset, animated: true)
        }
    }
    
    fileprivate func findFirstResponderBeneathView(_ view: UIView) -> UIView? {
        for childView in view.subviews {
            if childView.responds(to: #selector(getter: isFirstResponder)) && childView.isFirstResponder {
                return childView
            }
            let result = findFirstResponderBeneathView(childView)
            if result != nil {
                return result
            }
        }
        return nil
    }
    
    fileprivate func updateContentInset() {
        let state = keyboardState()
        if state.keyboardVisible {
            contentInset = contentInsetForKeyboard()
        }
    }
    
    fileprivate func calculatedContentSizeFromSubviewFrames() -> CGSize {
        let wasShowingVerticalScrollIndicator = showsVerticalScrollIndicator
        let wasShowingHorizontalScrollIndicator = showsHorizontalScrollIndicator
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        var rect = CGRect.zero
        for view in self.subviews {
            rect = rect.union(view.frame)
        }
        rect.size.height += kCalculatedContentPadding
        showsVerticalScrollIndicator = wasShowingVerticalScrollIndicator
        showsHorizontalScrollIndicator = wasShowingHorizontalScrollIndicator
        return rect.size
    }
    
    fileprivate func idealOffsetForView(_ view:UIView?, viewAreaHeight: CGFloat) -> CGFloat {
        let contentSize = self.contentSize
        var offset: CGFloat = 0.0
        let subviewRect =  view != nil ? view!.convert(view!.bounds, to: self) : CGRect.zero
        var padding = (viewAreaHeight - subviewRect.height)/2
        if padding < kMinimumScrollOffsetPadding {
            padding = kMinimumScrollOffsetPadding
        }
        
        offset = subviewRect.origin.y - padding - self.contentInset.top
        if offset > (contentSize.height - viewAreaHeight) {
            offset = contentSize.height - viewAreaHeight
        }
        if offset < -contentInset.top {
            offset = -contentInset.top
        }
        return offset
    }
    
    fileprivate func contentInsetForKeyboard() -> UIEdgeInsets {
        let state = keyboardState()
        var newInset = contentInset
        let keyboardRect = state.keyboardRect
        newInset.bottom = keyboardRect.size.height - max(keyboardRect.maxY - bounds.maxY, 0)
        return newInset
        
    }
    
    fileprivate func viewIsValidKeyViewCandidate(_ view: UIView) -> Bool {
        if view.isHidden || !view.isUserInteractionEnabled {return false}
        if view is UITextField {
            if let _ = (view as? UITextField)?.isEnabled {
                return true
            }
        }
        
        if view is UITextView {
            if let _ = (view as? UITextView)?.isEditable {
                return true
            }
        }
        return false
    }
    
    fileprivate func findNextInputViewAfterView(_ priorView: UIView, beneathView view: UIView, candidateView bestCandidate: inout UIView?) {
        let priorFrame = convert(priorView.frame, to: priorView.superview)
        let candidateFrame = bestCandidate == nil ? CGRect.zero : convert(bestCandidate!.frame, to: bestCandidate!.superview)
        let sqrtF = sqrt(candidateFrame.origin.x*candidateFrame.origin.x + candidateFrame.origin.y*candidateFrame.origin.y)
        var bestCandidateHeuristic = -sqrtF  + ( Float(abs(candidateFrame.minY - priorFrame.minY)) < .ulpOfOne ? 1e6 : 0)
        
        for childView in view.subviews {
            if viewIsValidKeyViewCandidate(childView) {
                let frame = convert(childView.frame, to: view)
                let heuristic = -sqrt(frame.origin.x*frame.origin.x + frame.origin.y*frame.origin.y)
                    + (Float(abs(frame.minY - priorFrame.minY)) < .ulpOfOne ? 1e6 : 0)
                
                if childView != priorView && (Float(abs(frame.minY - priorFrame.minY)) < .ulpOfOne
                    && frame.minX > priorFrame.minX
                    || frame.minY > priorFrame.minY)
                    && (bestCandidate == nil || heuristic > bestCandidateHeuristic) {
                    bestCandidate = childView
                    bestCandidateHeuristic = heuristic
                }
            } else {
                findNextInputViewAfterView(priorView, beneathView: view, candidateView: &bestCandidate)
            }
        }
    }
    
    fileprivate func findNextInputViewAfterView(_ priorView: UIView, beneathView view: UIView) -> UIView? {
        var candidate: UIView?
        findNextInputViewAfterView(priorView, beneathView: view, candidateView: &candidate)
        return candidate
    }
    
    @objc fileprivate func assignTextDelegateForViewsBeneathView(_ obj: AnyObject) {
        func processWithView(_ view: UIView) {
            for childView in view.subviews {
                if childView is UITextField || childView is UITextView {
                    initializeView(childView)
                } else {
                    assignTextDelegateForViewsBeneathView(childView)
                }
            }
        }
        
        if let timer = obj as? Timer, let view = timer.userInfo as? UIView {
            processWithView(view)
        } else if let view = obj as? UIView {
            processWithView(view)
        }
    }
    
    fileprivate func initializeView(_ view: UIView) {
        if let textField = view as? UITextField,
            let delegate = self as? UITextFieldDelegate, textField.returnKeyType == UIReturnKeyType.default &&
            textField.delegate !== delegate {
            textField.delegate = delegate
            let otherView = findNextInputViewAfterView(view, beneathView: self)
            textField.returnKeyType = otherView != nil ? .next : .done
        }
    }
    
    fileprivate func keyboardState() -> KeyboardState {
        if let state = objc_getAssociatedObject(self, &AssociatedKeysKeyboard.key) as? KeyboardState {
            return state
        } else {
            let state = KeyboardState()
            self.state = state
            return state
        }
    }
}
private class KeyboardState {
    var priorInset = UIEdgeInsets.zero
    var priorScrollIndicatorInsets = UIEdgeInsets.zero
    var keyboardVisible = false
    var keyboardRect = CGRect.zero
    var priorContentSize = CGSize.zero
    var priorPagingEnabled = false
}

extension UIScrollView {
    fileprivate enum AssociatedKeysKeyboard {
        static var key = "KeyBoardSmart"
    }
    
    fileprivate var state: KeyboardState? {
        get { // get
            let optionalObject = objc_getAssociatedObject(self, &AssociatedKeysKeyboard.key) as AnyObject?
            if let object = optionalObject {
                return object as? KeyboardState
            } else {
                return nil
            }
        }
        set { // set
            objc_setAssociatedObject(self, &AssociatedKeysKeyboard.key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
