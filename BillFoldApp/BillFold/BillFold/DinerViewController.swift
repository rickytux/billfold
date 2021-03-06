//
//  Created by Michael Pourhadi on 7/3/14.
//  Copyright (c) 2014 Michael Pourhadi. All rights reserved.
//

import UIKit
// import GPUImage

class DinerViewController: UITableViewController {

    
    @IBOutlet var toolbarView: UIToolbar
    @IBOutlet var totalUpdater: UILabel
    var currentDinerIndex:NSInteger = NSInteger()
    var total = Double()
    let attributeDictionary = [UITextAttributeTextColor: UIColor.whiteColor(), UITextAttributeFont: UIFont(name: "Helvetica Neue", size: 25)]
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }

    override func tableView(tableView: UITableView!, didHighlightRowAtIndexPath indexPath: NSIndexPath!) {
        currentDinerIndex = indexPath!.row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.destinationViewController is FoodTableViewController {
            var foodTableControllerWithName = segue.destinationViewController as FoodTableViewController
            foodTableControllerWithName.currentDinerIndex = currentDinerIndex
        }
    }
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var deletePerson = indexPath.row
            for foodItem in sharedDinerStorage.dinerList[deletePerson].foodItems {
                foodItem.counter -= 1
            }
            sharedDinerStorage.dinerList.removeAtIndex(deletePerson)
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let parsedFoodView = ParsedReceiptViewController() as UITableViewController
        let navController = UINavigationController(rootViewController: parsedFoodView)
        self.presentViewController(navController, animated: true, completion: nil)
        self.navigationItem.hidesBackButton = true
        toolbarView.translucent = true
        
        
        totalUpdater.text = "Loading Current Total"
        
        //styling
        navigationController.navigationBar.setTitleVerticalPositionAdjustment(2, forBarMetrics: UIBarMetrics.Default)
        navigationController.navigationBar.titleTextAttributes = attributeDictionary
        totalUpdater.textAlignment = NSTextAlignment.Center
        navigationItem.title = "Diners"
        self.tableView.backgroundColor = lightBlue
    }

    override func viewDidAppear(animated: Bool){
                total = sharedFoodController.calcTotalBill()
        totalUpdater.text = "Current Total: $\(String(total))"
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return sharedDinerStorage.dinerList.count
    }

    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        let dinerCell = tableView!.dequeueReusableCellWithIdentifier("diner", forIndexPath: indexPath) as UITableViewCell

        dinerCell.text = sharedDinerStorage.dinerList[indexPath.row].name

        return dinerCell
    }
}
