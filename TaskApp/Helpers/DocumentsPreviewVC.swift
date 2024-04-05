//
//  DocumentsPreviewVC.swift
//  TaskApp
//
//  Created by gokul on 05/04/24.
//

import UIKit
import QuickLook


class DocumentsPreviewVC: QLPreviewController, QLPreviewControllerDataSource {
    
    var documentData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the view controller as the data source
        dataSource = self
    }
    
    // MARK: - QLPreviewControllerDataSource
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return PreviewItem(data: documentData)
    }
}

// Custom QLPreviewItem implementation to handle data

class PreviewItem: NSObject, QLPreviewItem {
    var previewItemURL: URL?
    var previewItemTitle: String?
    
    init(data: Data?) {
        if let data = data {
            let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp.pdf")
            do {
                try data.write(to: tempURL)
                previewItemURL = tempURL
                previewItemTitle = "Preview"
            } catch {
                print("Failed to write data to temporary file: \(error.localizedDescription)")
            }
        } else {
            print("No data provided")
        }
    }
}
