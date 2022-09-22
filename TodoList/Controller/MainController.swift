//
//  ViewController.swift
//  TodoList
//
//  Created by 최진용 on 2022/09/20.
//

import UIKit

class MainController : UIViewController{
    
    func deleteList(of idx :Int) {
        print("ditem \(idx)")
        deleteItem(item: models[idx])
    }
    
    
    let myTableViewCell = MyTableViewCell()
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var models = [Todo]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad(){
        super.viewDidLoad()
        textfield.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "reusableCell")
        getAllItem()
        
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        textfieldReturn()
    }

    // 밀어서 삭제하기
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            deleteItem(item: models[indexPath.row])
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        } else if editingStyle == .insert {
//
//        }
//    }
    
    
    func textfieldReturn()->Bool{
        if textfield.text != ""{
            createNewItem()
            textfield.text = ""
            return true
        }else{
            let alert = UIAlertController(title: "경고", message: "내용을 입력해주세요", preferredStyle: UIAlertController.Style.alert)
            let defaultAlert = UIAlertAction(title: "ok", style: UIAlertAction.Style.default)
            alert.addAction(defaultAlert)
            self.present(alert, animated: false)
            return false
        }
    }
    
    
    //MARK: - CoreData
    func getAllItem(){
        do{
            models = try context.fetch(Todo.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            print("error occured")
        }
    }
    
    func createNewItem(){
        let newItem = Todo(context: context)
        newItem.listString = textfield.text
        do{
            try context.save()
            print("saved")
            getAllItem()
        }catch{
            print("can not make new item")
        }
    }
    
    func deleteItem(item : Todo){
        print("item \(item)")
        context.delete(item)
        do{
            try context.save()
            print("deleted")
            getAllItem()
        }catch{
            print("can not delete item")
        }
    }
}


//MARK: - UITextFieldDelegate

extension MainController : UITextFieldDelegate{
    //작성한거 return 누르면 데이터 업데이트 해주고 리렌더링 해주고
    // 작성한게 없으면 알람창 뜨게 만듬.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfieldReturn()
    }
}



//MARK: - UITableViewDataSource

extension MainController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! MyTableViewCell
        cell.memoLable.text = model.listString
        cell.action = { [weak self] in
                       guard let self = self else { return }
            print("index \(indexPath.row)")
            self.deleteItem(item: self.models[indexPath.row])
        
        }
                
        return cell
    }
    

    
}


//MARK: - UITableViewDelegate

extension MainController : UITableViewDelegate{

}

