//
//  ViewController.swift
//  ActivityList
//
//  Created by Alfredo Luco on 20-05-15.
//  Copyright (c) 2015 Alfredo Luco. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var busqueda: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var AddText: UITextField!
    var ActivityList: [String] = []
    var filtered: [String] = []
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        AddText.hidden = true
        TableView.delegate = self
        busqueda.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func AddActivity(sender: UIBarButtonItem) {
        if(!AddText.hidden){
            var lastActivity: UILabel! = UILabel()
            if var label : UILabel! = lastActivity{
                label.text = AddText.text
            }
            ActivityList.append(lastActivity.text!)
            println(lastActivity.text)
            println(ActivityList)
            //agregar a la tabla y actualizar
            self.TableView.reloadData()
            //self.TableView.reloadData()
            AddText.text = ""
            AddText.hidden = true
        }else{
            AddText.hidden = false
        }
    }
    //Actualizar el ViewTable
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive){
            return filtered.count
        }
        if (!ActivityList.isEmpty){
            return ActivityList.count
        }else{
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "k\(indexPath)")
        
        //cell.addSubview(ActivityList[indexPath.row] as! UIView)
        if (searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        }else{
            cell.textLabel?.text = ActivityList[indexPath.row]
        }
        println("Celda Agregada")
        println(cell.textLabel)
        
        return cell
    }
    
    //Motor de busqueda
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = self.ActivityList.filter({ (text: String) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.TableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
    }

    //motor de eliminacion
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            ActivityList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}

