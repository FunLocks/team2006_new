//
//  ChatListViewController.swift
//  ChatAppWithFirerbase
//
//  Created by 佐々木翔太 on 2020/12/16.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ChatListViewController: UIViewController {
   
    private let cellID = "cellId"
    private var users = [User]()
    
    @IBOutlet weak var chatListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        navigationController?.navigationBar.barTintColor = .rgb(red: 39, green: 49, blue:69)
        navigationItem.title = "トーク"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        if Auth.auth().currentUser?.uid == nil{
            let storyboar = UIStoryboard(name: "SignUp", bundle: nil)
            let signUpViewController = storyboar.instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
            signUpViewController.modalPresentationStyle = .fullScreen
            self.present(signUpViewController, animated: true, completion: nil)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUserInfoFromFiretore()
    }
    
    
    private func fetchUserInfoFromFiretore() {
        Firestore.firestore().collection("users").getDocuments{ (snapshots, err) in
            if let err = err {
                print("user情報の取得に失敗しました。\(err)")
                return
            }
            
            snapshots?.documents.forEach({ (snapshot) in
            let dic = snapshot.data()
            let user = User.init(dic: dic)
                
            self.users.append(user)
            
                
                self.users.forEach { (user) in
                    print("user.username: ", user.username)
                }
            })
            
        }
    }
    
}

//MARK-UITableViewDelegate,UITableViewDataSource
extension ChatListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatListTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatListTableViewCell
            cell.user = users[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("tapped table view")
        let storyboard = UIStoryboard.init(name: "ChatRoom", bundle: nil)
        let chatRoomViewController = storyboard.instantiateViewController(withIdentifier: "ChatRoomViewController")
        navigationController?.pushViewController(chatRoomViewController, animated: true)
    }
    
}

class ChatListTableViewCell: UITableViewCell{
    
    var user: User? {
        didSet{
            partnerLabel.text = user?.username
            
  //          userimageView.image = user?.profileImageUrl
            
        }
    }
    
    @IBOutlet weak var partnerLabel: UILabel!
    @IBOutlet weak var latestMesssageLabel: UILabel!
    @IBOutlet weak var userimageView: UIImageView!
    @IBOutlet weak var dataLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userimageView.layer.cornerRadius = 35
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated:animated )
    }
}
    

