//
//  TableAdapter.swift
//  NYTimesViewer
//
//  Created by Yevhen Triukhan on 20.08.2020.
//  Copyright © 2020 Yevhen Triukhan. All rights reserved.
//

import UIKit

public enum TableEvent {
    
    case didReloadData
    case didSelect(IndexPath)
    case didRemove(IndexPath)
    case loadNext
}

public class TableAdapter: NSObject, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    public var sections = [Section]() {
        didSet {
            self.table?.reloadData()
            UIView.animate(
                withDuration: 0.0,
                delay: 0,
                options: [.overrideInheritedOptions],
                animations: { self.table?.reloadData() },
                completion: { _ in self.eventHandler?(.didReloadData) }
            )
        }
    }
    
    public var eventHandler: Handler<TableEvent>?
    
    private weak var table: UITableView?
    private var isEndDragging: Bool = true
    
    // MARK: Init and Deinit
    
    public init(table: UITableView?, cells: [UITableViewCell.Type]) {
        self.table = table
        
        super.init()
        
        table?.dataSource = self
        table?.delegate = self
        cells.forEach {
            self.table?.register($0)
        }
    }
    
    // MARK: - TableView DataSource & Delegate
    
    public func reload() {
         self.table?.reloadData()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withCellClass: section.cell, for: indexPath)
        
        let value = cell as? AnyCellType
        let model = section.models[indexPath.row]
        
        value?.fill(with: model, eventHandler: section.eventHandler)
        
        return cell
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.eventHandler?(.didSelect(indexPath))
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.sections[section].header?.view
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let header = self.sections[section]
        return header.header?.height ?? 0
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.sections[indexPath.section].isEditing
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.sections[indexPath.section].models.remove(at: indexPath.row)
            self.eventHandler?(.didRemove(indexPath))
        default:
            break
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        let isNeedLoad = scrollView.contentSize.height > scrollView.frame.height
        if distance < 20 && velocity.y > 0 && isNeedLoad {
            self.eventHandler?(.loadNext)
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isEndDragging = false
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.isEndDragging = true
    }
}
