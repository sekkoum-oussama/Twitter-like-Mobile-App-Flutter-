As a back-end & Mobile developer, i wanted to design and implement a system from start to finish, from conceptualization to writing code, so i picked the twitter app(now X) ,the back-end is developed using Django and Django Rest Framework, the mobile app is developed using Flutter.
the app has : authentication, users registration, email confirmation, password reset, profile updating, adding, deleting, liking, unliking, quoting, retweeting and replying to tweets, the user can upload photos or videos either from storage or using device's camera, a user can also follow and unfollow other users.
In the back-end, the authentication was handled using both "allauth" and "dj-rest-auth" packages, i also used "debug_toolbar" to debug each request and especially SQL queries.
About SQL queries: when requesting tweets, there were more than 1000 queries performed, and after using some Django's ORM optimizations methods, i managed to reduce it to only 8 queries.
In the mobile app, Flutter had a rich set of packages that helped a lot, i used "flutter_secure_storage" to securely store sensitive data like token and refresh token, i used "shared_preferences" to store user information, the "camera" package to handle picking images and videos, and have more control over the camera options, "flutter_form_builder" to handle form validation, "photo_manager" to access and display photos and videos the way i wanted, "flutter_bloc"for state management.
![1714743094415](https://github.com/sekkoum-oussama/Twitter-like-Mobile-App-Flutter-/assets/69439465/20cb05d3-cef5-4e0a-ae5e-3ca1a69d62ec)


![1714743094407](https://github.com/sekkoum-oussama/Twitter-like-Mobile-App-Flutter-/assets/69439465/bc92fc34-d13b-4f5a-9724-3184922ecebf)

![1714743094395](https://github.com/sekkoum-oussama/Twitter-like-Mobile-App-Flutter-/assets/69439465/8fc051ec-d4ee-4ecc-a522-1a4e219523e5)

![1714743094356](https://github.com/sekkoum-oussama/Twitter-like-Mobile-App-Flutter-/assets/69439465/7e1f3b9c-18c5-4501-ba17-db2e7d93fcd5)

![1714743094343](https://github.com/sekkoum-oussama/Twitter-like-Mobile-App-Flutter-/assets/69439465/12d5884c-cee2-4286-80ef-1a732aaaa045)
