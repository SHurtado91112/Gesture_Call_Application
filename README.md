# Zippy Contact

![zippy-icon small](https://user-images.githubusercontent.com/11231583/35194495-58322a2c-fe82-11e7-8cec-16a273fe18a1.png)

Zippy Contact will allow you to save time in making a phone call by assigning a unique gesture to listed contacts in your phone.

Made by: Steven Hurtado, Andrei Gurau, Jake Locke

# Inspiration

You're driving. You don't have much time to find the person you need to call. Siri's misunderstanding you again... Instead of having to sift through hundreds of contacts to make a phone call or by having to search through the contacts list by typing a name, one could save time and prevent an accident from occurring by simply performing a swiping motion on our canvas to be able to immediately make a call. Quick phone calls are now made much more accessible and personable by adding flair to a contact rather than using their phone number.

# Development

We used Swift to build an iOS app using the k-Nearest-Neighbors algorithm in order to learn your custom gestures by keeping track of the coordinates of every touchpoint. After grabbing all of the phone's stored contacts, the coordinates of the gesture will be compared to the ten similar gestures saved to each contact. If the user's gesture on the canvas is close enough to the ten saved swipes on a contact, the user would be prompted with an alert in order to proceed with the call.

# Challenges

Most of our team hadn't been exposed to machine learning algorithms. Having to learn, rewrite, and apply the KNN algorithm to our application was certainly a daunting task. Furthermore, another challenge that we had was to take the training data and use it real-time instead of having pre-processed data. This created a tradeoff between a reasonable amount of input for the user and having enough training data to optimize the classifier.

# What's next

Since all of our data is currently stored locally on someone's phone, having multiple saved gestures would consume a lot of space and slow the app down. One way to remedy this issue is to store all the data on a server in order to save space.

As of right now, the application is only able to be used to call people but its purposes can be expandable, such as unlocking a door, turning on your lights, and much, much more. We believe that this application's gesture-recognition ability could be used to save time and add convenience to your life while adding private, personalized security.

Alternatively, the app could utilize motion control in order to perform various functions instead of having to use screen gestures.
