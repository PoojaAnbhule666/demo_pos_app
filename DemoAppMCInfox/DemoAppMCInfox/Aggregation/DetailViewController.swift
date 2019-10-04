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
    @available(iOS 11.0, *)
    class DetailViewController: UIViewController {
        
        @IBOutlet weak var nodataView: UIView!
        @IBOutlet weak var aggregateDetail_TableView: UITableView!
        
        var detailData_ = [DetailData]()
        //     fileprivate let viewModel = AggregateViewModel()
        let colorSucess = UIColor(named: "ColorSucces")
        let colorFail = UIColor(named: "ColorFail")
        
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
            //            print("DetailView")
            super.viewDidLoad()
            if detailData_.count != 0 {
                print("DetailView")
                nodataView.isHidden = false
            } else {
                nodataView.isHidden = true
            }
            aggregateDetail_TableView?.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
            // Auto resizing the height of the cell
            aggregateDetail_TableView.estimatedRowHeight = 100.0
            aggregateDetail_TableView.rowHeight = UITableView.automaticDimension
            
            
        }
        // MARK: - date formate
        func dateformate(dateString : String) -> String {
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ"
            let dateString = dateString
            
            let date = dateFormatterGet.date(from: dateString)!
            dateFormatterGet.dateFormat = "dd-MM-yyyy"
            let dateStr = dateFormatterGet.string(from: date)
            return dateStr
        }
        
        func creteDateStringFromString(str : String) -> String {
            //        var str = "2019090612"
            let year = str.index(str.startIndex, offsetBy: 0)..<str.index(str.endIndex, offsetBy: -8)
            let substringYear = str[year]
            let day = str.index(str.startIndex, offsetBy: 4)..<str.index(str.endIndex, offsetBy: -6)
            let _day = str[day]
            let month = str.index(str.startIndex, offsetBy: 6)..<str.index(str.endIndex, offsetBy: -4)
            let _month = str[month]
            let hour = str.index(str.startIndex, offsetBy: 8)..<str.index(str.endIndex, offsetBy: -2)
            let _hours = (" \(str[hour])")
            
            let dateStr = substringYear + "-" + _day + "-" + _month + _hours
            print(dateStr)
            return dateStr
        }
        
    }
    
    // MARK: - View Controller DataSource and Delegate
    //
    @available(iOS 11.0, *)
    extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
        
        public func numberOfSections(in tableView: UITableView) -> Int {
            //            return delegate?.numberOfSections?(tableView) ?? 1
            
            return detailData_.count
        }
        
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let numberOfRows = 1
            return isSectionCollapsed(section) ? 0 : numberOfRows
        }
        
        // Cell
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandCell") as! ExpandCell
            
            cell.tid_label.text = String(detailData_[indexPath.section].tid!)
            cell.orgSlipNo_label.text = detailData_[indexPath.section].orgSlipNumber
            cell.paymentDivison_Label.text = detailData_[indexPath.section].paymentDivision
            cell.approveNo_label.text = String(detailData_[indexPath.section].approveNumber!)
            cell.errorCode_label.text = detailData_[indexPath.section].errorCode
            cell.autoCancelSts_label.text = detailData_[indexPath.section].autoCancelStatus
            cell.captureSend_label.text = detailData_[indexPath.section].captureSend
            cell.processingNo_label.text = detailData_[indexPath.section].processingNumber
            
            return cell
        }
        
        public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
        
        // Header
        public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
            //            header.arrowLabel.text = ">"
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView
            
            headerView?.transactionType_Label.text = detailData_[section].type
            headerView?.slipNo_Label.text =  String(detailData_[section].slipNumber!)
            headerView?.brandName_Label.text =  detailData_[section].cardCompanyName
            headerView?.amount_Label.text = String(detailData_[section].amount!)
            
            let status = detailData_[section].paymentStatus
            
            if status == "0" {
                headerView?.checkOk_label.text = "Ok"
                headerView?.containView.backgroundColor = colorSucess
            } else {
                headerView?.checkOk_label.text = "fail"
                headerView?.containView.backgroundColor = colorFail
            }
            headerView?.date_Label.text = creteDateStringFromString(str: detailData_[section].transactionDate ?? "")
            headerView?.setCollapsed(isSectionCollapsed(section))
            headerView?.section = section
            headerView?.delegate = self
            return headerView
        }
        
        public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return  100.0    }
        
        public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return  0.0
        }
        
    }
    
    //
    // MARK: - Section Header Delegate
    //
    @available(iOS 11.0, *)
    extension DetailViewController: HeaderViewDelegate {
        
        func toggleSection(_ section: Int) {
            let sectionsNeedReload = getSectionsNeedReload(section)
            aggregateDetail_TableView.reloadSections(IndexSet(sectionsNeedReload), with: .automatic)
        }
        
    }
    
