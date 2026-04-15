# Example: Linus Torvalds roasts callback hell

## Input code

```javascript
app.get('/dashboard', function(req, res) {
    db.getUser(req.userId, function(err, user) {
        if (err) { res.send('error'); return; }
        db.getPosts(user.id, function(err, posts) {
            if (err) { res.send('error'); return; }
            db.getComments(posts.map(p => p.id), function(err, comments) {
                if (err) { res.send('error'); return; }
                db.getNotifications(user.id, function(err, notifs) {
                    if (err) { res.send('error'); return; }
                    res.render('dashboard', {
                        user: user,
                        posts: posts,
                        comments: comments,
                        notifications: notifs
                    });
                });
            });
        });
    });
});
```

## Roast output (savage)

````
    ┌──────────────────┐
    │    ◉  ╭╮  ◉      │
    │      ════        │
    │   ╱┌────────┐╲   │
    │    │REJECTED│    │
    │    └────────┘    │
    │                  │
    │  ╲              ╱│
    │   ╲____________╱ │
    └──────────────────┘
  *slams laptop shut, reopens it,
   reads again, slams it harder*
````

Let me paint a picture of what you've done here. You've written code that indents to the right like it's trying to escape off the edge of the screen. This is the Pyramid of Doom, and the pharaoh buried inside it is your career.

1. **Async/await has existed since 2017.** That's nine years ago. ES2017. Node 7.6. It shipped before some of the junior developers reading this code were in high school. You are writing callbacks in the year of our lord as if `async function` is some bleeding-edge experimental feature. It is not. It is older than most JavaScript frameworks you probably also misuse. There is no excuse. None.

2. **`res.send('error')`** — let me savor this. You have four different database operations that can fail in four different ways, and your error handling strategy for all of them is to send the string `'error'` to the user. Not an error code. Not a message. Not a status. The literal word "error." Your user sees something go wrong and gets the most useless response in the history of HTTP. You might as well send `res.send('something bad happened lol')` — it would carry the same informational content, which is zero.

3. **Every single one of these queries runs sequentially.** Look at your code. `getComments` waits for `getPosts`. Fine, it needs the post IDs. But `getNotifications` has absolutely nothing to do with posts or comments — it only needs `user.id`, which you had after the first callback. You are making your users wait for three sequential database round-trips before you even START fetching notifications. `Promise.all` exists. It has existed for over a decade. You could cut your response time nearly in half by running independent queries in parallel, but that would require understanding what your own code does, and clearly we're not there yet.

4. **You redeclare `err` four times in nested scopes.** Each callback shadows the previous `err`. If you ever need to log the actual error from an outer scope — which you should, because `res.send('error')` tells nobody anything — you can't. It's gone. Shadowed into oblivion. You have built a system where debugging requires a séance.

5. **The indentation IS the architecture.** Your control flow is expressed entirely through nesting depth. The business logic — "load a dashboard" — is buried at indentation level 5. If you add one more data source, you're at level 6. Two more and you'll need a horizontal scrollbar. This is not scalable. This is not readable. This is a geological cross-section of bad decisions layered on top of each other.

Here's what this should look like, and I'm not even going to charge you for the lesson:

```javascript
app.get('/dashboard', async (req, res) => {
    try {
        const user = await db.getUser(req.userId);
        const [posts, notifs] = await Promise.all([
            db.getPosts(user.id),
            db.getNotifications(user.id)
        ]);
        const comments = await db.getComments(posts.map(p => p.id));
        res.render('dashboard', { user, posts, comments, notifications: notifs });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
```

Flat. Parallel where possible. Actual error information. Written like someone who has opened a browser tab in the last decade.

Your code is a time capsule from 2013, except in 2013 people at least had the excuse that Promises weren't standardized yet. You don't even have that. Delete this, write it properly, and never nest a callback more than one level deep again.
