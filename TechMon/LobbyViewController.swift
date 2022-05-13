//
//  LobbyViewController.swift
//  TechMon
//
//  Created by Atsuhiro Muroyama on 2022/05/10.
//

import UIKit

class LobbyViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaLabel: UILabel!
    var stamina: Int = 100
    var staminaTimer: Timer!
    
    let techMonManager = TechMonMager()
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "勇者"
        //UIの設定
        staminaLabel.text = "\(stamina) / 100"
        // Do any additional setup after loading the view.
        //タイマーの説明
        staminaTimer = Timer.scheduledTimer(timeInterval: 3,
                                            target: self,
                                            selector: #selector(self.updateStaminaValue),
                                            userInfo: nil,
                                            repeats: true)
        staminaTimer.fire()
    }
    @objc func updateStaminaValue() {
      if stamina < 100 {
        stamina += 1
        staminaLabel.text = "\(stamina)/100"
     }
    }
   //ロビー画面が見えるようになるときにやる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        techMonManager.playBGM(fileName: "lobby")
    }
    //ロビー画面が見えなくなるときにやる
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        techMonManager.stopBGM()
    }
    @IBAction func toBattle(){
        if stamina >= 50 {
            stamina -= 50
            staminaLabel.text = "\(stamina) / 100"
            performSegue(withIdentifier: "toBattle", sender: nil)
        }else {
            let alert = UIAlertController(
            title: "バトルに行けません",
            message: "スタミナをためて下さい",
            preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style: .default, handler: nil))
            present(alert, animated:  true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


