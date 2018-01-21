# Zippy Contact

Zippy Contact will allow you to save time in making a phone call by assigning a unique gesture to listed contacts in your phone.

Made by: Steven Hurtado, Andrei Gurau, Jake Locke

# Inspiration

You're driving. You don't have much time to find the person you need to call. Siri is hard of hearing again... Instead of having to sift through hundreds of contacts to make a phone call or by having to search through the contacts list by typing a name, one could save time and prevent an accident from occuring by simply performing a swiping motion on our canvas to be able to immediately make a call. Quick phone calls are now made much more accessible and personable by adding flair to a contact rather than using their phone number. 

# Development

We used Swift to build an iOS app using the k-Nearest-Neighbors algorithm in order to learn the swiping motion by keeping track of the coordinates of every few milliseconds. After grabbing all of the phone's stored contacts, the coordinates of the gesture will be compared to the 5 similar gestures saved to each contact. If the user's gesture on the canvas is close enough to the five saved swipes on a contact, the user would be prompted with an alert in order to proceed with the call.

# Challenges

Most of our team haven't been exposed to machine learning algorithms or developed a proper iOS application before. Also, having to learn, rewrite, and apply the KNN algorithm to our application was certainly a daunting task. TO FINISH LATER

# What's next

Since all of our data is currently stored locally on someone's phone, having multiple saved gestures would consume a lot of space and slow the app down. One way to remedy this issue is to store all the data in order to save space.
