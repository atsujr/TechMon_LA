//
//  BattleViewController.swift
//  TechMon
//
//  Created by Atsuhiro Muroyama on 2022/05/10.
//

import UIKit

class BattleViewController: UIViewController {
    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var playerImageView: UIImageView!
    @IBOutlet var playerHPLabel: UILabel!
    @IBOutlet var PlayerMPLabel: UILabel!
    @IBOutlet var PlayerTPLabel: UILabel!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var enemyHPLabel: UILabel!
    @IBOutlet var enemyMPLabel: UILabel!
    
    let techMonManager = TechMonMager()
    
    var player: Character!
    var enemy: Character!
    //キャラクター読み込
    
    var playerHP = 100
    var playerMP = 0
    var enemyHP = 200
    var enemyMP = 0
    
    var gameTimer: Timer!
    var isPlayerAttackedAvailable: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player = Character(name: "勇者", imageName: "yusya.png", attackPoint: 30, maxHP: 500, maxTp: 100, maxMp: 20)
        enemy = Character(name: "ドラゴン", imageName: "monster.png", attackPoint: 20, maxHP: 500, maxTp: 0, maxMp: 35)
        playerNameLabel.text = "勇者"
        playerImageView.image = UIImage(named: "yusya.png")
        playerHPLabel.text = "\(player.currentHP) / 100"
        PlayerMPLabel.text = "\(player.currentMP) / 20"
        enemyNameLabel.text = "龍"
        
        enemyImageView.image = UIImage(named: "monster.png")
        enemyHPLabel.text = "\(enemy.currentHP) / 200"
        enemyMPLabel.text = "\(enemy.currentHP) / 35"
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        gameTimer.fire()
    }

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        techMonManager.playBGM(fileName: "BGM_battele001")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        techMonManager.stopBGM()
    }
//    @objc func updateGame() {
//        player.currentMP += 2
//        if playerMP >= 20 {
//            isPlayerAttackedAvailable = true
//            playerMP = 20
//        }else {
//            isPlayerAttackedAvailable = false
//        }
//        //敵のステータス更新
//        enemyMP += 2
//        if enemyMP >= 35 {
//            enemyAttack()
//            enemyMP = 0
//        }
//       PlayerMPLabel.text = "\(playerMP) / 20"
//       enemyMPLabel.text = "\(enemyMP) / 35"
//
//       // updateUI()
//    }
    @objc func updateGame() {
        player.currentMP += 2
        if player.currentMP >= 20 {
            isPlayerAttackedAvailable = true
            player.currentMP = 20
        }else {
            isPlayerAttackedAvailable = false
        }
        //敵のステータス更新
        enemy.currentMP += 2
        if enemy.currentMP >= 35 {
            enemyAttack()
            enemy.currentMP = 0
        }
        PlayerMPLabel.text = "\(player.currentMP) / 20"
        enemyMPLabel.text = "\(enemy.currentMP) / 35"

       // updateUI()
    }
    func enemyAttack() {
        techMonManager.animateDamage(playerImageView)
        techMonManager.playBGM(fileName: "SE_attack")
        
//        playerHP -= 20
        player.currentHP -= 20
        //playerHPLabel.text = "\(playerHP) / 100"
        
        updateUI()
//        if playerHP <= 0 {
//            finishBattle(vanishhImageView: playerImageView, isPlayerWin: false)
//
//        }
        judgebuttle()
    }
    func finishBattle(vanishhImageView: UIImageView, isPlayerWin: Bool){
        techMonManager.animateVanish(vanishhImageView)
        techMonManager.stopBGM()
        gameTimer.invalidate()
        isPlayerAttackedAvailable = false
        
        var finishMessage: String = ""
        if isPlayerWin {
            techMonManager.playBGM(fileName: "SE_fanfare")
            finishMessage = "勇者の勝利!!"
        }else {
            techMonManager.playBGM(fileName: "SE_gameover")
            finishMessage = "勇者の敗北!!"
        }
        let alert = UIAlertController(title: "バトル終了", message: finishMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func attackAction(){
        if isPlayerAttackedAvailable {
            techMonManager.animateDamage(enemyImageView)
            techMonManager.playSE(fileName: "SE_attack")
//            enemyHP -= 30
//            playerMP = 0
            enemy.currentHP -= player.attackPoint
            player.currentTP += 10
            if player.currentTP >= player.maxTP {
                player.currentTP = player.maxTP
            }
            player.currentMP = 0
//           enemyHPLabel.text = "\(enemyHP) / 200"
//            PlayerMPLabel.text = "\(playerMP) / 20"
            updateUI()
            
//
//            if enemyHP <= 0 {
//                finishBattle(vanishhImageView: enemyImageView, isPlayerWin: true)
//            }
            judgebuttle()
            }
        }
    @IBAction func tameruAction() {
        if isPlayerAttackedAvailable {
            print("🐴")
            techMonManager.playSE(fileName: "SE_charge")
            player.currentTP += 40
            if player.currentTP >= player.maxTP {
                player.currentTP = player.maxTP
            }
            player.currentMP = 0
        }
    }
    @IBAction func fireAction(){
        if isPlayerAttackedAvailable && player.currentTP >= 40 {
            
            techMonManager.animateDamage(enemyImageView)
            techMonManager.playSE(fileName: "SE_fire")
            
            enemy.currentHP -= 100
            
            player.currentTP -= 40
            if player.currentTP <= 0 {
                player.currentTP = 0
            }
            player.currentMP = 0
            
            judgebuttle()
        }
    }
    func updateUI(){
        
        playerHPLabel.text = "\(player.currentHP) / \(player.maxHP)"
        PlayerMPLabel.text = "\(player.currentMP)/ \(player.maxMP)"
        PlayerTPLabel.text = "\(player.currentTP)/ \(player.maxTP)"
        enemyHPLabel.text = "\(enemy.currentHP) / \(enemy.maxHP)"
        enemyMPLabel.text = "\(enemy.currentMP)/ \(enemy.maxMP)"
    }
    func judgebuttle() {
        if player.currentHP <= 0 {
            finishBattle(vanishhImageView: playerImageView, isPlayerWin: false)
        }else if enemy.currentHP <= 0{
            finishBattle(vanishhImageView: enemyImageView, isPlayerWin: true)
        }
        
    }
    }
    

