//
//  TransactionHistoryMapper.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 8/5/20.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

import Foundation

protocol TransactionHistoryMapperProtocol {
    associatedtype DataModel where DataModel: TransactionModelProtocol
    associatedtype CellAdapter where CellAdapter: TransactionHistoryCellAdapter
    func mapToSections(operationList: [DataModel]) -> [TableViewSectionModel<CellAdapter>]
}

class TransactionHistoryMapper<
    DataModel: TransactionModelProtocol,
    CellAdapter: TransactionHistoryCellAdapter
    >: TransactionHistoryMapperProtocol where DataModel == CellAdapter.DataModel
{
    func mapToSections(operationList: [DataModel]) -> [TableViewSectionModel<CellAdapter>] {
        var grouped: [String: [CellAdapter]] = [:]
        operationList.forEach { model in
            let sectionKeyDateString = getDateStringKey(from: model.date)
            let cellAdapter = CellAdapter(dataModel: model)
            if grouped[sectionKeyDateString] == nil {
                grouped[sectionKeyDateString] = [cellAdapter]
            } else {
                grouped[sectionKeyDateString]?.append(cellAdapter)
            }
        }
        let sectionModels: [TableViewSectionModel<CellAdapter>] = grouped
            .map({ key, value in
                TableViewSectionModel(
                    title: key,
                    items: value,
                    backgroundColor: Color.mainWhite,
                    onSelection: { _ in })
            })
            .sorted (by: {
                guard let firstDate = $0.items.first?.date, let secondDate = $1.items.first?.date else {
                    return false
                }
                return firstDate > secondDate
            })
        return sectionModels
    }
    
    private func getDateStringKey(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        let localeIdentifier = SupportedLanguage
            .defineCurrentLanguage()
            .locale
            .identifier
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        let weekdayIndex = dateFormatter.calendar.component(.weekday, from: date)
        let weekday = dateFormatter.calendar.shortWeekdaySymbols[weekdayIndex - 1]
        
        let dateMarkers = DateMarkers(for: date, from: dateFormatter.calendar)
        guard dateMarkers.isThisYear else {
            dateFormatter.dateFormat = GlobalConstants.DateFormat.dayWithFullMonthAndYearComma
            return dateFormatter.string(from: date).uppercased()
        }
        if dateMarkers.isToday {
            return ("JB_TODAY".localized() + ", \(weekday)").uppercased()
        }
        if dateMarkers.isYesterday {
            return ("JB_YESTERDAY".localized() + ", \(weekday)").uppercased()
        }
        dateFormatter.dateFormat = GlobalConstants.DateFormat.dayWithFullMonthAndWeekday
        return dateFormatter.string(from: date).uppercased()
    }
}
