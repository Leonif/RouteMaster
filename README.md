# RouteMaster
Test Task for interview

Task requirements:
1. User interface should has text field for search addresses, where user input text 
2. Table should show result of address searching below
3. You can use Google Places API or Apple CoreLocation
4. When user click on cell, app shows next screen with map and route to selected point
5. Need to support iOS 9 and 10.
6. App needs to be run on iPhone only
7. Rest of implementation as you wish


Implementation:

<img width="317" alt="screen1" src="https://user-images.githubusercontent.com/22885814/27000714-de146b28-4dc0-11e7-8622-b27e1d3657d2.png"> <img width="318" alt="screen2" src="https://user-images.githubusercontent.com/22885814/27000744-83549f54-4dc1-11e7-9b8d-b4fb29c0ee32.png">

1. Two targets were created in order to use two approach of address searching: 
  - CLGeocoder (according to task above - support iOS 9)
  - Apple autocomplete (supported since iOS 9.3 - in order to learn subject)
2. Cocoapods has external library with alert controler in case user refused access geolocation (cocoapods skill)
<img width="317" alt="alert" src="https://user-images.githubusercontent.com/22885814/27000699-7e79de14-4dc0-11e7-9e8f-1ac49b64e4f2.png">
