//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Alexandra Saunders on 6/3/16.
//  Copyright © 2016 Alexandra Saunders. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listVIew: UIImageView!
    
    let yellowColor = UIColor(red: 225/225, green: 225/255, blue: 0, alpha: 1)
    let greenColor = UIColor(red: 100/225, green: 200/255, blue: 40/225, alpha: 1)
    
    var mailOriginalCenter: CGPoint!
    var feedOriginalCenter: CGPoint!
    var mailLeft: CGPoint!
    var mailRight: CGPoint!
    var archiveIconOriginalCenter: CGPoint!
    var laterIconOriginalCenter: CGPoint!
    var deleteIconOriginalCenter: CGPoint!
    var listIconOriginalCenter: CGPoint!
    
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: 320, height: 1370)
        
        mailLeft = mailView.center
        mailRight = mailView.center
        rescheduleView.alpha = 0
        listVIew.alpha = 0
        
        deleteIcon.alpha = 0
        view.backgroundColor = UIColor.lightGrayColor()
        
        //        archiveIcon.alpha = 0
        //        laterIcon.alpha = 0
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            mailOriginalCenter = mailView.center
            feedOriginalCenter = feedView.center
            archiveIconOriginalCenter = archiveIcon.center
            laterIconOriginalCenter = laterIcon.center
            deleteIconOriginalCenter = deleteIcon.center
            listIconOriginalCenter = listIcon.center
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            mailView.center = CGPoint(x: mailOriginalCenter.x + translation.x, y: mailOriginalCenter.y)
            
            if translation.x > 60 && translation.x < 260 {
                deleteIcon.alpha = 0
                archiveIcon.alpha = 1
                archiveIcon.center.x = archiveIconOriginalCenter.x - 60
                view.backgroundColor = greenColor
            } else if translation.x > 260 {
                archiveIcon.alpha = 0
                deleteIcon.alpha = 1
                deleteIcon.center.x = archiveIcon.center.x
                view.backgroundColor = UIColor.redColor()
            } else if translation.x < -60 && translation.x > -260 {
                laterIcon.alpha = 1
                listIcon.alpha = 0
                laterIcon.center.x = laterIconOriginalCenter.x + 60
                view.backgroundColor = yellowColor
            } else if translation.x < -260 {
                laterIcon.alpha = 0
                listIcon.alpha = 1
                listIcon.center.x = laterIcon.center.x
                view.backgroundColor = UIColor.brownColor()
            } else {
                archiveIcon.alpha = 1
                deleteIcon.alpha = 0
                view.backgroundColor = UIColor.lightGrayColor()
                
            }
            
            
        } else if sender.state ==  UIGestureRecognizerState.Ended {
            
            if abs(translation.x) < 60  {
                self.mailView.center.x = self.mailOriginalCenter.x
                archiveIcon.center.x = archiveIconOriginalCenter.x
                self.deleteIcon.center.x = self.archiveIcon.center.x
            } else if translation.x > 60 && translation.x < 260 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.mailView.center.x = self.mailOriginalCenter.x + 320
                    self.mailView.alpha = 0
                    self.archiveIcon.center.x = self.archiveIconOriginalCenter.x
                    self.deleteIcon.center.x = self.deleteIconOriginalCenter.x
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.feedView.center.y = self.feedView.center.y - 88
                            self.view.backgroundColor = UIColor.lightGrayColor()
                            
                        })
                })
            } else if translation.x > 260 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.mailView.center.x = self.mailOriginalCenter.x + 320
                    self.mailView.alpha = 0
                    self.archiveIcon.center.x = self.archiveIconOriginalCenter.x
                    self.deleteIcon.center.x = self.deleteIconOriginalCenter.x
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.feedView.center.y = self.feedView.center.y - 88
                            self.view.backgroundColor = UIColor.lightGrayColor()
                            
                        })
                })
            } else if translation.x < -60 && translation.x > -260 {
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.mailView.center.x = self.mailOriginalCenter.x - 320
                    self.mailView.alpha = 0
                    self.laterIcon.center.x = self.laterIconOriginalCenter.x
                    self.listIcon.center.x = self.listIconOriginalCenter.x
                    }, completion: { (Bool) -> Void in
                        self.rescheduleView.alpha = 1
                })
            } else if translation.x < -260 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.mailView.center.x = self.mailOriginalCenter.x - 320
                    self.mailView.alpha = 0
                    self.laterIcon.center.x = self.laterIconOriginalCenter.x
                    self.listIcon.center.x = self.listIconOriginalCenter.x
                    }, completion: { (Bool) -> Void in
                        self.listVIew.alpha = 1
                        
                })
                
            } else {
                view.backgroundColor = UIColor.lightGrayColor()
            }
            
            
            //            if velocity.x > 0 && translation.x < 60 {
            //                    self.mailView.center.x = self.mailOriginalCenter.x
            //            } else if velocity.x > 0 && translation.x > 60 && translation.x < 260 {
            //                UIView.animateWithDuration(0.3, animations: { () -> Void in
            //                    self.mailView.center.x = self.mailOriginalCenter.x + 320
            //                    self.mailView.alpha = 0
            //                    self.archiveIcon.center.x = self.archiveIconOriginalCenter.x
            //                    self.laterIcon.center.x = self.laterIconOriginalCenter.x
            //                    }, completion: { (Bool) -> Void in
            //                    self.feedView.center.y = self.feedView.center.y - 88
            //                })
            //            } else if velocity.x > 0 && translation.x > 260 {
            //                UIView.animateWithDuration(0.3, animations: { () -> Void in
            //                    self.mailView.center.x = self.mailOriginalCenter.x + 320
            //                    self.archiveIcon.center.x = self.archiveIconOriginalCenter.x
            //                    self.laterIcon.center.x = self.laterIconOriginalCenter.x
            //                })
            //            }
            
            
            
        }
        
    }
    
    
    @IBAction func didTapList(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.listVIew.alpha = 0
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.mailView.alpha = 0
                    self.feedView.center.y = self.feedView.center.y - 88
                    self.view.backgroundColor = UIColor.lightGrayColor()
                    
                })
        }
    }
    
    @IBAction func didTapReschedule(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.rescheduleView.alpha = 0
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.mailView.alpha = 0
                    self.feedView.center.y = self.feedView.center.y - 88
                    self.view.backgroundColor = UIColor.lightGrayColor()
                    
                })
        }
    }
    
    @IBAction func didTapNav(sender: UITapGestureRecognizer) {
        print("refresh")
        UIView.animateWithDuration(0.3) { () -> Void in
            self.mailView.alpha = 1
            self.feedView.center.y = self.feedOriginalCenter.y
            self.mailView.center.x = self.mailOriginalCenter.x
        }
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
