//
//  Player.swift
//  TechDra
//
//  Created by Master on 2015/03/24.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

import UIKit

class Character {
    var name: String = ""
    var image: UIImage!
    var attackPoint: Int = 30
    
    var currentHP: Int = 100
    var currentTP: Int = 0
    var currentMP: Int = 0
    
    var maxHP: Int = 100
    var maxTP: Int = 20
    var maxMP: Int = 20
    
    init(name: String, imageName: String, attackPoint: Int, maxHP: Int, maxTp: Int, maxMp: Int){
        self.name = name
        self.image = UIImage(named: imageName)
        self.attackPoint = attackPoint
        self.currentHP = maxHP
        self.maxHP = maxHP
        self.maxTP = maxTp
        self.maxMP = maxMp
        
    }
    func resetStatus(){
        currentHP = maxHP
        currentTP = 0
        currentMP = 0
        
    }

}
