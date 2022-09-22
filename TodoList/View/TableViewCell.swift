//
//  TableViewCell.swift
//  TodoList
//
//  Created by 최진용 on 2022/09/20.
//

import UIKit
import CoreData
protocol UITabelViewCellDelegate{
    func deleteList(of idx: Int)
}


class MyTableViewCell: UITableViewCell {
    
    var change = true
    var idx: Int = -1
    var action :() -> ()  = { }
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var memoLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pressDelete(_ sender: UIButton) {
//        tableVIew 
        //누르면 지금 있는데이터 지우고 테이블뷰 리로드 해줘야함.
        
        print("idx : \(self.idx)")
        self.action()
       
    }
    
    @IBAction func pressCheck(_ sender: UIButton) {
        change.toggle()
        if let memo = memoLable.text, !change {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: memo)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            memoLable.attributedText = attributeString
            memoLable.textColor = UIColor.gray
            checkBox.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            
        }
        else{
            if let memo = memoLable.text{
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:  memo)
                attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
                memoLable.attributedText = attributeString
                memoLable.textColor = UIColor.black
                checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
            }
        }
    }
}
