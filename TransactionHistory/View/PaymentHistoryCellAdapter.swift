//
//  PaymentHistoryCellAdapter.swift
//  JuniorBank
//
//  Created by Zhandos Bolatbekov on 8/5/20.
//  Copyright © 2020 STRONG Team. All rights reserved.
//

import UIKit

struct PaymentHistoryCellAdapter: TransactionHistoryCellAdapter, TableViewCellRepresentable {
    typealias DataModel = PaymentOperationModel
    
    var date: Date
    
    var title: String
    
    var subtitle: String?
    
    var imageUrl: URL?
    
    var rightViewKind: LogoCellRightView.Kind {
        .details(titleParams: detailTitleParams, subtitleParams: (nil, nil, nil))
    }
    
    private var detailTitleParams: LogoCellDetailParams {
        return (nil, getAmountTextColor(), StringUtils.formatWithAttributes(
            amount: -abs(dataModel.amount),
            signed: true,
            useSymbol: true,
            mainAttributes: LabelFactory.makeAttributes(
                for: .paragraphBody,
                textAlignment: .right),
            fractionalAttributes: LabelFactory.makeAttributes(
                for: .smallHelper,
                textAlignment: .right)))
    }
    
    let dataModel: DataModel
    
    init(dataModel: DataModel) {
        self.dataModel = dataModel
        title = dataModel.title ?? ""
        subtitle = dataModel.subtitle ?? ""
        if let iconPath = dataModel.logoImg,
            let url = URL(string: EnvConfigs.baseUrl)?
                .appendingPathComponent(CommonConfigs.resourcesPath)
                .appendingPathComponent(iconPath) {
            imageUrl = url
        }
        date = dataModel.date
    }
    
    private func getAmountTextColor() -> UIColor {
        switch dataModel.status {
        case .introduced, .waiting:
            return Color.mainAttention
        case .failure, .expired:
            return Color.mainRed
        case .success:
            return Color.textHighContrast
        }
    }
}
