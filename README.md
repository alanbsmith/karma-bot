# KarmaBot

## So... what is this?
KarmaBot is a simple bot for sharing karma in Slack.

## Ok... but what's 'karma'?
You can think of karma (in this context) sort of like points that are assigned to users. When someone does something you like, you can bump someone's score up. You can also bump someone's score down, but remember what goes around, comes around.

### Can you give me a tangible example?
Sure. Let's say someone delivered some awesome new mockups or shares a great gif.
```
alan [3:57 PM]
sara ++

karmabotAPP [3:57 PM]
sara is on the rise! Karma: 10
```

Basically, it's a fun way to tell someone you appreciate or enjoy something they did.

## Commands
Here's a list of commands:
* `karmabot list`: returns a list of users and their karma
* `karmabot top`: returns top 10 users
* `karmabot bottom`: returns bottom 10 users
* `karma create username`: creates a new user
* `username ++`: adds karma to user
* `username --`: removes karma from user
* `karma empty username`: resets user's karma
* `karma destroy username`: deletes user

### INVITE
KarmaBot has to be explicitly invited to channels. If you'd like it to be in one of your channels, type:
```
/invite @karmabot
```

### LIST
KarmaBot is really new, so there's a good chance that most people haven't created an account. If you want to see who's on the list, you can say:
```
karmabot list
```

### TOP
If you want to know who's got great karma, type
```
karmabot top
```
to see the top 10 people. Keep in mind that the score is largely arbitrary, but competition to be in the top 10 is encouraged.

### BOTTOM
If you want to see who is doing poorly, you can type
```
karmabot bottom
```
This list is generally populated with barely-functioning office equipment, Internet service providers, unpopular days of the week, and other dead horses.

### CREATE
If you'd like to create a new account, type:
```
karma create username
```
If you're creating karma for yourself (or someone else on slack), try to use a slack handle for their username. That'll make it easier for someone to give them karma later.

### ADD KARMA
Sharing karma is easy. If you'd like to give someone karma, type:
```
username ++
And if there's several people you'd like to thank at once:
user1 ++ user2 ++ user3 ++
```

### REMOVE KARMA
Removing karma works the same as adding.
```
username --
```
or for groups:
```
user1 -- user2 -- user3 --
```
### EMPTY
You can also reset someone's karma back to 0. This is a rare use case, but was intended for if someone leaves slack.
```
karma empty username
```

### DESTROY
You can also delete an account. Maybe you misspelled someone's name during creation, or they're no longer in Slack. To remove them entirely, type:
```
karma destroy username
```
