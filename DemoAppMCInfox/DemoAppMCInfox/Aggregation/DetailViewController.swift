//
//  DetailViewController.swift
//  DemoAppMCInfox
//
//  Created by CAFIS_Mac_1 on 16/09/19.
//  Copyright © 2019 NTTDATA_Cafis. All rights reserved.
//

import UIKit

@objc public protocol CollapsibleTableSectionDelegate {
    @objc optional func shouldCollapseByDefault(_ tableView: UITableView) -> Bool
    @objc optional func shouldCollapseOthers(_ tableView: UITableView) -> Bool
}
class DetailViewController: UIViewController {

    @IBOutlet weak var aggregateDetail_TableView: UITableView!
    
//     fileprivate let viewModel = AggregateViewModel()
    
    public var delegate: CollapsibleTableSectionDelegate?
    var _sectionsState = [Int : Bool]()
    
    public func isSectionCollapsed(_ section: Int) -> Bool {
        if _sectionsState.index(forKey: section) == nil {
            _sectionsState[section] = delegate?.shouldCollapseByDefault?(aggregateDetail_TableView) ?? true
        }
        return _sectionsState[section]!
    }
    
    func getSectionsNeedReload(_ section: Int) -> [Int] {
        var sectionsNeedReload = [section]
        
        // Toggle collapse
        let isCollapsed = !isSectionCollapsed(section)
        
        // Update the sections state
        _sectionsState[section] = isCollapsed
        
        let shouldCollapseOthers = delegate?.shouldCollapseOthers?(aggregateDetail_TableView) ?? false
        
        if !isCollapsed && shouldCollapseOthers {
            // Find out which sections need to be collapsed
            let filteredSections = _sectionsState.filter { !$0.value && $0.key != section }
            let sectionsNeedCollapse = filteredSections.map { $0.key }
            
            // Mark those sections as collapsed in the state
            for item in sectionsNeedCollapse { _sectionsState[item] = true }
            
            // Update the sections that need to be redrawn
            sectionsNeedReload.append(contentsOf: sectionsNeedCollapse)
        }
        
        return sectionsNeedReload
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello")
        aggregateDetail_TableView?.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        // Auto resizing the height of the cell
        aggregateDetail_TableView.estimatedRowHeight = 44.0
        aggregateDetail_TableView.rowHeight = UITableView.automaticDimension
        
        
    }
    
}

// MARK: - View Controller DataSource and Delegate
//
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        //            return delegate?.numberOfSections?(tableView) ?? 1
        
        return 4
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = 1
        return isSectionCollapsed(section) ? 0 : numberOfRows
    }
    
    // Cell
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //            return delegate?.collapsibleTableView?(tableView, cellForRowAt: indexPath) ?? UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "DefaultCell")
        
        let expandCell = tableView.dequeueReusableCell(withIdentifier: "ExpandCell") as! ExpandCell
        return expandCell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // Header
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        //
        //            let title = delegate?.collapsibleTableView?(tableView, titleForHeaderInSection: section) ?? ""
        //
        //            header.titleLabel.text = title
        //            header.arrowLabel.text = ">"
        //            header.setCollapsed(isSectionCollapsed(section))
        //
        //            header.section = section
        //            header.delegate = self
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView
        
        
        //            header.brandName_Label.text = tittle
        headerView?.amount_Label.text = "1000"
        headerView?.setCollapsed(isSectionCollapsed(section))
        
        headerView?.section = section
        headerView?.delegate = self
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  90.0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  0.0
    }
    
}

//
// MARK: - Section Header Delegate
//
extension DetailViewController: HeaderViewDelegate {
    
    func toggleSection(_ section: Int) {
        let sectionsNeedReload = getSectionsNeedReload(section)
        aggregateDetail_TableView.reloadSections(IndexSet(sectionsNeedReload), with: .automatic)
    }
    
}

