//
//  DescriptionTextView.swift
//  MainTrack-Prototype
//
//  Created by Clay Suttner on 3/14/21.
//

import UIKit

class DescriptionTextView: PlaceholderTextView {
    
    var scrollDelegate: CellScrollDelegate!

    override func textViewDidBeginEditing(_ textView: UITextView) {
        super.textViewDidBeginEditing(textView)
        scrollDelegate.scrollTo(indexPath: IndexPath(row: 0, section: 1))
    }
    
    override func textViewDidEndEditing(_ textView: UITextView) {
        scrollDelegate.removeSpace()
    }
    
}
