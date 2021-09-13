### Description

A sample iOS application to demonstrate the registration and monitoring of geofences.

### Architecture

This application uses a Model View Presenter - Coordinator pattern. For each screen you see, the code is split into 3 sections:
- View
- Model
- Presenter

The ViewController is responsible to manage user interaction with the screen and presenting data returned by the presenter. View delegates and datasources are kept inside the View Controller as these logic are related to view and will need to be handled in the view controller.

The model is stored inside the presenter. The view controller does not have any reference to the View Model. The View Model is only used by the presenter to store values and states of the current screen. The View Controller only displays whatever the presenter returns.

The presenter is where the bulk of the logic for each screen resides. The presenter should be written to have little to no dependancies to the UI framework. This is to ensure that the tests can be written for the presenter without requiring any views to be created.

#### How is the View Controller connected to the presenter?

The view controller has a strong reference to the presenter. Why is this so? This could be the only strong reference to the presenter that we have.

How does the presenter communicate with the view controller? Because I love delegates so much, I use the delegate pattern with a weak reference to the view controller to communicate back to the view controller. The View Controller will then need to conform to the protocol for the presenter delegate.

#### How is the navigation handled in the application?

This application uses a Coordinator to handle the navigation. As this is a small application, the creation of each screen(view controller and its presenters) is also handled by the coordinator. If the creation of these said screens grow to be more complex, factories should be used to handle the creation of the screens.

The presenter should then communicate to the Coordinator when a screen needs to be shown. If the presenter or view controller needs to respond to specific events from the coordinator, you guessed it, we will have a protocol for either the presenter or view controller to respond to.


### Feature List
- Upon bootup, the application will check if location permission is enabled. If not, the application will prompt for the user to enable location permission.
- Retrieval of SSID using SystemConfiguration.CaptiveNetwork. Entitlement file is needed for this to work. Not using NEHotspotNetwork to not have 2 branching logic for different levels of iOS.
- Handling of Core Location's Authorisation Status.
- Creation of Monitored Region. User is able to select the radius and which triggers the monitoring should trigger: on entry, on exit, or both. Monitored region can only be created at the current user location at the moment.
- In-application check to see if user is inside the monitored region. This uses the Core Location feature which checks if user's current location is inside the region.
- Assigning WIFI SSID to a specific region. If a WIFI SSID is assigned to a specific region, the application will check if for the current WIFI SSID value to determine if the user is inside a monitored region.
- The monitored region is stored using UserDefaults at the moment. As we are only monitoring a single region at the moment, this seems ok.

### What can be improved?
- Add multiple regions to monitor.
- Removal of Wifi SSID from current assigned region.
- Add option to create region from other locations.
- Handling of Location Permission on each screen.
- History of geofence monitoring trigger.
- Handling of region monitor when application is active. At the moment, it's just a local notification.