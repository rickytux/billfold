//
//  ParsedReceiptTableViewController.swift
//  BillFold
//
//  Created by Michael Pourhadi on 7/9/14.
//  Copyright (c) 2014 Michael Pourhadi. All rights reserved.
//

import UIKit

class ParsedReceiptViewController: UITableViewController {

    var foodToKeep = ParsedFood[]()
    let doneButton = UIBarButtonItem()
    let addFoodButton = UIBarButtonItem()
    let attributeDictionary = [UITextAttributeTextColor: UIColor.whiteColor()]
    
    func doneButtonTap(sender: UIButton!) {
        sharedFoodController.foodAndPrices = foodToKeep
        navigationController.dismissModalViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.editing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
        addFoodButton.title = "Add Item To Receipt"
        addFoodButton.target = self
        addFoodButton.action = "addButtonTap:"
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.prompt = "You may add or remove items later"
        self.navigationItem.title = "Select items to keep"
        doneButton.style = UIBarButtonItemStyle.Plain
        doneButton.title = "Done"
        doneButton.target = self
        doneButton.action = "doneButtonTap:"

        // colors
        self.tableView.backgroundColor = lightBlue
        doneButton.tintColor = UIColor.whiteColor()
        navigationController.navigationBar.barTintColor = lightColor
        navigationController.navigationBar.titleTextAttributes = attributeDictionary
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let selectedFood = sharedFoodController.foodAndPrices[indexPath.row] as ParsedFood
        foodToKeep += selectedFood
       // println("tapdown: \(foodToKeep.count)")
    }
    
    override func tableView(tableView: UITableView!, didDeselectRowAtIndexPath indexPath: NSIndexPath!) {
        let selectedFood = sharedFoodController.foodAndPrices[indexPath.row]
   
        for var i = 0; i <= foodToKeep.count - 1; i++ {
            if (selectedFood === foodToKeep[i]) {
                foodToKeep.removeAtIndex(i)
            }
        }
    }
    
    // #pragma mark - Table view data source
    
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var sharedFoodStore = sharedFoodController
            sharedFoodStore.foodAndPrices.removeAtIndex(indexPath.row)
        }
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return sharedFoodController.foodAndPrices.count
    }
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        
        let foodCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "foodItem") as UITableViewCell
        
        let specificFoodItem = sharedFoodController.foodAndPrices[indexPath.row].food
        let price = sharedFoodController.foodAndPrices[indexPath.row].price
        
        foodCell.text = specificFoodItem
        foodCell.detailTextLabel.text = "Cost: $\(price)"
        
        return foodCell
    }
}
