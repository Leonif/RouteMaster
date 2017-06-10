# RouteMaster
Test Task for interview

Task requeraments:
1. User interface should has text field for search addresses, where user input text 
2. Table should show result of address searching below
3. You can use Google Places API or Apple CoreLocation
4. When user click on cell, app show next screen with map and route to selected point
5. Need to support iOS 9 and 10.
6. App need be run on iPhone only
7. Rest of implementation as you wish

Implementation:
1. Two targets were created in order to use two approach of address searching: 
  - CLGeocoder (according to task above support iOS 9)
  - Apple autocomplete (supported since iOS 9.3)
2. Cocoapods has external library with alert controler in case user refused access geolocation
