# meal-recipes-case-study

### Story: Customer requests to see their image feed

### Narrative #1

```
As an online customer
I want the app to automatically load my latest image feed
So I can always enjoy the newest food images from application
```

#### Scenarios (Acceptance criteria)

```
Given the customer has connectivity
 When the customer requests to see their feed
 Then the app should display the latest feed from remote
 
```

### Narrative #2

```
As an offline customer
I want the app to show the latest saved version of my food image 
So I can always enjoy images of my friends
```

#### Scenarios (Acceptance criteria)

```
Given the customer doesn't have connectivity
 When the customer requests to see the feed
 Then the app should display the latest feed saved

Given the customer doesn't have connectivity
  And the the customer have a saved collection
 When the customer requests to see the saved feed
 Then the app should display an saved feed

Given the customer doesn't have connectivity
  And the saved image is empty
 Then the app should display an empty feed image
```
