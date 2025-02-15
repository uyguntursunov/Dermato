Dermato iOS App

Architecture: MVP, 100% programmatic UI, Autolayout with SnapKit, Alamofire for Network Requests, Localization, Persistance Manager(CoreData)

Description: Dermato is a mobile app which helps to users with skin problems. The main functionality of the app is Skin Scanner which works based on AI model developed with [HAM10000](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/DBW86T) dataset. The workflow goes in following order:
1. User opens the app, scans his/her skin by taking a photo within the app(image can be uploaded from photo library as well).
2. The image data will be sent to backend via network request, and the processed result will be displayed to the user(the result is an info about skin disease). The taken photos will be saved to CoreData Persitance Manager, so the user can monitor the cahnges. The image data will not be stored in different database - this is for privacy purposes(medical secret).

Other functionalities:

Daily tips: Users get daily tips about skincare and anti-aging solutions.

Daily facts: Users first learn about the dermatologic facts, and then they can earn points by solving the quiz based on the facts they read(the earned points can be used within the app to purchase skincare products - Gemification).

Skincare products: Different skincare products from several marketplaces. 

Chat with AI: Users can ask questions regarding dermatology and get fast responses online 24/7.

News: Users can check daily local news in the field of medicine. 

Currently the app works in 2 languages: Uzbek and English(Russin is in the plans as well).



![alt text](https://github.com/uyguntursunov/Dermato/blob/assets/IMG_0190.PNG) 



![alt text](https://github.com/uyguntursunov/Dermato/blob/assets/IMG_0191.PNG)



![alt text](https://github.com/uyguntursunov/Dermato/blob/assets/IMG_0192.PNG)



![alt text](https://github.com/uyguntursunov/Dermato/blob/assets/IMG000%20(2).jpg)



![alt text](https://github.com/uyguntursunov/Dermato/blob/assets/IMG_0193.PNG)












 


