//
//  FMLContainerViewController.swift
//  FarmersMarketLocator
//
//  Created by Magfurul Abeer on 4/13/16.
//  Copyright © 2016 Jeff Spingeld. All rights reserved.
//

import UIKit
import SnapKit

class FMLContainerViewController: UIViewController {
    
    let mapViewController = FMLMapViewController()
    var dogViewController = DogViewController()
    let cartViewController = CartViewController()
    let resourcesViewController = FMLResourcesViewController()
    var petals = [UIImageView]()
    let petalLeft = UIImageView(image: UIImage(named: "Petal"))
    let petalRight = UIImageView(image: UIImage(named: "Petal"))
    let infoImage = UIImageView(image: UIImage(named: "Receptacle"))
    
    @IBOutlet weak var receptacleButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var vineButton: UIButton!

    
    var blurEffectView = UIVisualEffectView()
    var vineImageView = UIImageView()
    var vineOutline = UIImageView()
    var hamburger = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.masksToBounds = false
        self.setEmbeddedViewController(mapViewController)
        self.receptacleButton.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(120),          CGAffineTransformMakeTranslation(0, 250))
        
        let value: Double = ((20 * M_PI)/180.0)
        let degrees: CGFloat = CGFloat(value)
        self.vineButton.transform = CGAffineTransformMakeRotation(degrees)
        
        createBlurView()
        addHamburgerImage()
        addFlower()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FMLContainerViewController.makeVineDisappear), name: "LeafMeAlone", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FMLContainerViewController.makeVineReappear), name: "VineAndDine", object: nil)
    }
    
    // MARK: Vine Menu Methods
    
    func addHamburgerImage() {
        hamburger = UIImageView(frame: CGRectMake(25, 40, 40, 40))
        hamburger.image = UIImage(named: "three")
        hamburger.alpha = 0.3
        self.view.addSubview(hamburger)
        print("done")
    }

    func makeVineDisappear() {
        UIView.animateWithDuration(0.3) { 
            self.vineButton.alpha = 0
            self.hamburger.alpha = 0
        }
    }
    
    func makeVineReappear() {
        UIView.animateWithDuration(0.3) { 
            self.vineButton.alpha = 1
            self.hamburger.alpha = 1
        }
    }
    
    func createBlurView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FMLContainerViewController.emptySpaceTapped))
        blurEffectView.addGestureRecognizer(tapGesture)
    }
    
    
    // MARK: Gesture Methods
    
    // MARK: IBActions
    
    @IBAction func vineButtonTapped(sender: UIButton) {
        self.view.addSubview(blurEffectView)
        self.vineButton.hidden = true
        
        addVineImage()
        showVineImage()
        showFlowerButton()
    }
    
    func addVineImage() {
        let image = UIImage(named: "VineSolid")
        vineImageView =  UIImageView(frame: CGRectMake(20, -418, 163, 490))
        vineImageView.image = image
        self.view.addSubview(vineImageView)
        
        let value: Double = ((20 * M_PI)/180.0)
        let degrees: CGFloat = CGFloat(value)
        vineImageView.transform = CGAffineTransformMakeRotation(degrees)
    }
    
    func showVineImage() {
        let animationDuration: NSTimeInterval = 0.6
        
        UIView.animateWithDuration(animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.vineImageView.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(0, 418), CGAffineTransformIdentity)
            
        }) { (bool) -> Void in
        }
        
        performSelector(#selector(FMLContainerViewController.showButtons), withObject: nil, afterDelay: animationDuration/2)
    }
    
    func mapTapped() {
        self.setEmbeddedViewController(mapViewController)
        self.emptySpaceTapped()
    }
    
    func cartTapped() {
        self.setEmbeddedViewController(cartViewController)
        self.emptySpaceTapped()
    }
    
    func bookTapped() {
        self.setEmbeddedViewController(resourcesViewController)
        self.emptySpaceTapped()
    }
    
    func dogTapped() {
        self.setEmbeddedViewController(dogViewController)
        self.emptySpaceTapped()
    }
    
    
    func showButtons() {
        //        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside
        
        vineOutline = UIImageView(frame: CGRectMake(20, 0, 163, 490))
        vineOutline.image = UIImage(named: "VineOutline")
        vineOutline.alpha = 0
        vineOutline.userInteractionEnabled = true
        
        let mapButton = UIButton(type: UIButtonType.Custom) as UIButton
        mapButton.frame = CGRectMake(67, 70, 50, 50)
        let mapImage = UIImage(named: "mappin")
        mapButton.setImage(mapImage, forState: UIControlState.Normal)
        mapButton.addTarget(self, action: #selector(FMLContainerViewController.mapTapped), forControlEvents: UIControlEvents.TouchUpInside)
        vineOutline.addSubview(mapButton)
        
        let groceryButton = UIButton(type: UIButtonType.Custom) as UIButton
        groceryButton.frame = CGRectMake(60, 185, 50, 50)
        let groceryImage = UIImage(named: "cart")
        groceryButton.setImage(groceryImage, forState: UIControlState.Normal)
        groceryButton.addTarget(self, action: #selector(FMLContainerViewController.cartTapped), forControlEvents: UIControlEvents.TouchUpInside)
        vineOutline.addSubview(groceryButton)
        
        let resourceButton = UIButton(type: UIButtonType.Custom) as UIButton
        resourceButton.frame = CGRectMake(70, 300, 50, 50)
        let resourceImage = UIImage(named: "book")
        resourceButton.setImage(resourceImage, forState: UIControlState.Normal)
        resourceButton.addTarget(self, action: #selector(FMLContainerViewController.bookTapped), forControlEvents: UIControlEvents.TouchUpInside)
        vineOutline.addSubview(resourceButton)
        
        
        let searchButton = UIButton(type: UIButtonType.Custom) as UIButton
        searchButton.frame = CGRectMake(70, 420, 50, 50)
        let searchImage = UIImage(named: "dog")
        searchButton.setImage(searchImage, forState: UIControlState.Normal)
        searchButton.addTarget(self, action: #selector(FMLContainerViewController.dogTapped), forControlEvents: UIControlEvents.TouchUpInside)

        vineOutline.addSubview(searchButton)
        
        
        self.view.addSubview(vineOutline)
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.vineOutline.alpha = 1
            self.vineImageView.alpha = 0
        }
    }
    
    func emptySpaceTapped() {
        self.vineOutline.alpha = 0
        self.vineImageView.alpha = 1
        for i in (0..<self.petals.count) {
            UIView.animateWithDuration(0.2) {
                self.petals[i].transform = CGAffineTransformIdentity
            }
            
        }
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.vineImageView.transform = CGAffineTransformMakeTranslation(0, 100)
            self.receptacleButton.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(120),          CGAffineTransformMakeTranslation(0, 250))
        }) { (bool) -> Void in
            
            UIView.animateWithDuration(0.1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                let value: Double = ((20 * M_PI)/180.0)
                let degrees: CGFloat = CGFloat(value)
                self.vineImageView.transform = CGAffineTransformMakeRotation(degrees)
                
            }) { (bool) -> Void in
                
                self.vineOutline.removeFromSuperview()
                self.vineImageView.removeFromSuperview()
                self.blurEffectView.removeFromSuperview()
                self.vineButton.hidden = false
                self.petalRight.alpha = 1
                self.petalLeft.alpha = 1
                self.infoImage.alpha = 0
            }
            
        }
        
        
    }
    
    // Flower
    func addFlower() {
        let stem = UIImageView(image: UIImage(named: "Stem"))
        self.receptacleButton.addSubview(stem)
        stem.snp_makeConstraints { (make) in
            make.height.equalTo(191)
            make.width.equalTo(42)
            make.left.equalTo(self.receptacleButton).offset(-29)
            make.top.equalTo(self.receptacleButton).offset(35)
        }
        
        for i in (1...20) {
            let petal = UIImageView(image: UIImage(named: "Petal"))
            self.receptacleButton.addSubview(petal)
            self.petals.append(petal)
            petal.snp_makeConstraints { (make) in
                make.height.equalTo(85)
                make.width.equalTo(40)
                make.centerX.equalTo(self.receptacleButton.snp_centerX)
                make.bottom.equalTo(self.receptacleButton.snp_centerY).offset(42)
            }
            petal.layer.anchorPoint = CGPointMake(0.5, 1.0)
            
        }
        
        self.receptacleButton.addSubview(petalLeft)
        petalLeft.snp_makeConstraints { (make) in
            make.height.equalTo(85)
            make.width.equalTo(40)
            make.centerX.equalTo(self.receptacleButton.snp_centerX)
            make.bottom.equalTo(self.receptacleButton.snp_centerY).offset(42)
        }
        petalLeft.layer.anchorPoint = CGPointMake(0.5, 1.0)
        petalLeft.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(100), CGAffineTransformMakeTranslation(0, 21))
        
        
        self.receptacleButton.addSubview(petalRight)
        petalRight.snp_makeConstraints { (make) in
            make.height.equalTo(85)
            make.width.equalTo(40)
            make.centerX.equalTo(self.receptacleButton.snp_centerX)
            make.bottom.equalTo(self.receptacleButton.snp_centerY).offset(42)
        }
        petalRight.layer.anchorPoint = CGPointMake(0.5, 1.0)
        petalRight.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(120), CGAffineTransformMakeTranslation(0, 21))
        
        
        self.receptacleButton.addSubview(infoImage)
        infoImage.snp_makeConstraints { (make) in
            make.height.equalTo(42)
            make.width.equalTo(42)
            make.centerX.equalTo(self.receptacleButton.snp_centerX)
            make.centerY.equalTo(self.receptacleButton.snp_centerY)
        }
        infoImage.alpha = 0
    }
    
    func showFlowerButton() {
        self.view.bringSubviewToFront(self.receptacleButton)
        self.performSelector(#selector(FMLContainerViewController.rotatePetals), withObject: nil, afterDelay: 0.2)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.receptacleButton.transform = CGAffineTransformIdentity
        }) { (bool) in
            UIView.animateWithDuration(0.5) {
                self.petalLeft.alpha = 0
                self.petalRight.alpha = 0
                self.infoImage.alpha = 1
            }
        }
        
    }
    
    func rotatePetals() {
        for i in (0..<self.petals.count) {
            UIView.animateWithDuration(0.8) {
                self.petals[i].transform = CGAffineTransformMakeRotation(10 * CGFloat((i+1)*2))
            }
        }
    }

    
    // MARK: Container View Handler Method
    
    // Thanks Tim Clem!
    func setEmbeddedViewController(controller: UIViewController?) {
        if self.childViewControllers.contains(controller!) {
            return
        }
        
        for vc in self.childViewControllers {
            vc.willMoveToParentViewController(nil)
            
            if vc.isViewLoaded() {
                vc.view.removeFromSuperview()
            }
            
            vc.removeFromParentViewController()
        }
        
        if (controller == nil) {
            return
        }
        
        self.addChildViewController(controller!)
        self.containerView.addSubview(controller!.view)
        controller!.view.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        controller?.didMoveToParentViewController(self)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}






















