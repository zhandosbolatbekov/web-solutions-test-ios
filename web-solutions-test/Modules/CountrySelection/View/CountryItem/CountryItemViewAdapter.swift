//
//  CountryItemViewAdapter.swift
//  web-solutions-test
//
//  Created by Zhandos Bolatbekov on 16.12.2020.
//

struct CountryItemViewAdapter {
    var iconName: String?
    var name: String
    var isSelected: Bool
    
    init(iconName: String?, name: String, isSelected: Bool) {
        self.iconName = iconName
        self.name = name
        self.isSelected = isSelected
    }
    
    init(country: Country, isSelected: Bool) {
        self.init(iconName: "icon_country_\(country.name)",
                  name: country.name,
                  isSelected: isSelected)
    }
}
