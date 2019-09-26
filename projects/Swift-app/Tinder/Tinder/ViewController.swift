//
//  ViewController.swift
//  Tinder
//
//  Created by watar on 2019/09/22.
//  Copyright © 2019 rui watanabe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var basicCard: UIView!
    
    
    @IBOutlet weak var likeImageView: UIImageView!
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    
    
    //変数の宣言
    //CGpointは型のこと
    //!は値がない時
    var centerOfCard:CGPoint!
    
    var people = [UIView]()
    
    var selectedCardCount: Int = 0
    
    let name = ["ほのか","あかね","みほ","カルロス"]
    var likedName = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初期値の真ん中の値で後で取り出したりする
        centerOfCard = basicCard.center
        
        //uiimageをは配列に追加する
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)

        
    }
    
    func resetCard() {
        //animationsの引数には、クロージャー（無名関数）と呼ばれるものを入れる
        //viewController自身のcenterOfCardですよということを明示的に示すためにselfを入れなければいけない
              basicCard.center = self.centerOfCard
              //.identityで元の角度をtransformに代入できる
             basicCard.transform = .identity
    }
    
    //セグウェイ実行時と同時にこの中の処理を実行する
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushList" {
            //destinationはセグウェイの遷移先
            //as!で型を変える
            let vc = segue.destination as! ListViewController
            //遷移先のlikednameをviewcontrollerのlikednameに入れる
            vc.likedName = likedName
        }
    }
    
    @IBAction func likebuttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
                self.resetCard()
                self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 500, y: self.people[self.selectedCardCount].center.y)
            })
            likeImageView.alpha = 0
            likedName.append(name[selectedCardCount])
            selectedCardCount += 1
        
            if selectedCardCount >= people.count{
                //セグウェイを実行
                performSegue(withIdentifier: "PushList", sender: self)
            }
    }
    
    @IBAction func dislikebuttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.resetCard()
            self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 500, y: self.people[self.selectedCardCount].center.y)
        })
        likeImageView.alpha = 0
        
        selectedCardCount += 1
        
        if selectedCardCount >= people.count{
            //セグウェイを実行
            performSegue(withIdentifier: "PushList", sender: self)
        }
    }
    
    //ドラックアンドドロップした時にこの関数が呼ばれる
    //basicCardの情報がsenderの中に入っている
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
      let card = sender.view!
      let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        people[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        //角度を変える
        let xFromCenter = card.center.x - view.center.x
        //角度を変えた値をtransformに代入する
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        people[selectedCardCount].transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        
        //右側にカードがある状態
        if xFromCenter > 0 {
            likeImageView.image = UIImage(named:"good")
            //初期値は透明だが、xFromCenterが0以上になった時は透明じゃなくさせる
            likeImageView.alpha = 1
            
            likeImageView.tintColor = UIColor.red
        
        }else if xFromCenter < 0{
            likeImageView.image = UIImage(named:"bad")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.blue
        }
        
        //カードを動かして指を離した時の処理
        //スワイプして離した時
        //senderはスワイプされた時の情報でstateは状態
        //今のスワイプの状況が指が離れた状態なら
        if sender.state == UIGestureRecognizer.State.ended{
              //左に大きくスワイプ
                if card.center.x < 75{
                    UIView.animate(withDuration: 0.2, animations: {
                        self.resetCard()
                        self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 250, y: self.people[self.selectedCardCount].center.y)
                    })
                    likeImageView.alpha = 0
                    
                    selectedCardCount += 1
                    
                    if selectedCardCount >= people.count{
                        //セグウェイを実行
                        performSegue(withIdentifier: "PushList", sender: self)
                    }
                    
                    //元に戻る処理が呼ばれないように、この関数は終了だといことを宣言する
                    return
                    } else if card.center.x > self.view.frame.width - 75 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.resetCard()
                        self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 250, y: self.people[self.selectedCardCount].center.y)
                    })
                    likeImageView.alpha = 0
                    likedName.append(name[selectedCardCount])
                    selectedCardCount += 1
                
                    if selectedCardCount >= people.count{
                        //セグウェイを実行
                        performSegue(withIdentifier: "PushList", sender: self)
                    }
                    
                    return
                }
              
                
              //元に戻す処理
               UIView.animate(withDuration: 0.2, animations: {
                self.resetCard()
                        self.people[self.selectedCardCount].center = self.centerOfCard
                self.people[self.selectedCardCount].transform = .identity
              })
            likeImageView.alpha = 0
        }
    
    }
    

}
