# Fuze CSTV

### CSTV
CSTV is an app that displays CS: GO matches happening across several worldwide tournaments


## Build:
- Xcode version  14.2 
- iPhone build version  16.0+ 
- ![Swift ](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)


## More
* [Personal decisions](#personal-decisions)
* [Pictures](#pictures)
* [Video](#video)

## Personal decisions
While developing this app I made the following decisions:
* Should I use a library?
	-
	For this app I decided not to use any kind of dependecies. The reason I chose this was because I was just doing simple API requests, alamofire could have saved me of doing big file of requests, but It wasn't many requests. Also, I didn't choose any dependency to cache the images, like Kingfisher for instance. NScache serves more than enough to cache the tableview images, as they are lightweight images. 
* Which architecture should I use?
	 -
	 I decided to use **MVC**. Don't get me wrong, I do love MVVM, it is amazing how it can make the code cleaner, better for testing and more scalable. But for simplicity I chose MVC 


	
## Pictures


<img src="https://user-images.githubusercontent.com/6657364/221444910-ebd288af-309b-4429-ad0c-947f1daf4bde.png" width="200" height="400">
<img src="https://user-images.githubusercontent.com/6657364/221445399-46504473-f4a7-4a4c-b2e7-7e8f9b96473d.png" width="200" height="400">
<img src="https://user-images.githubusercontent.com/6657364/221445400-033ce254-e311-4a0f-a0d0-e3e5691a409c.png" width="200" height="400">


## Video

https://user-images.githubusercontent.com/6657364/221445784-a673903a-6503-4d82-8aa2-722460015c6d.mp4

*The lag on the video it is due to the simulator*
