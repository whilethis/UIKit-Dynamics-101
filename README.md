This is the sample code from my "UIKit Dynamics 101" talk given at CocoaConf Atlanta 2013.

This repository contains a workspace with four projects.

#Collection View Dynamics
This project contains an iOS project that consists of a single collection view. The main purpose is to show how to use UIKit Dynamics with UICollectionViewLayoutAttributes.

This was heavily inspired (and uses code directly from) by Ash Furrow's obj.io article on Collection Views and UIKit Dynamics. It can be found at this URL: [http://www.objc.io/issue-5/collection-views-and-uidynamics.html](http://www.objc.io/issue-5/collection-views-and-uidynamics.html)

#Dynamics and Autolayout
This project contains an iOS application (run it on the iPhone) that consists of three boxes.

The center box is constrained to the center of the main view and the boxes to the left and right are constrained to the center box's y value. The outside boxes are also constrained to be a certain number of points to the left or right of the center box.

Tapping on the center box adds a gravity behavior and attaches the center box to it (-spoiler1). 

-spoiler 2 adds a dynamic item behavior to see what can be done to make autolayout trigger a layout pass.

Tapping on the left box changes the top contraint for the middle box to be 50 points from the top.

Not obvious, but this started off as a POC to see how Dynamics and Autolayout interact.

#GravityBox
This project contains a single box that has an attachment behavior that you can move around with touches.

Tapping on the box turns gravity on.

#Newton's Cradle
This project simulates the classic desk toy, Newton's Cradle. Currently, it only supports one tap.
