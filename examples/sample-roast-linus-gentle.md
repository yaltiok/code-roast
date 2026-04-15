# Example: Linus Torvalds roasts a poorly written API endpoint

## Input code

```python
def get_users(request):
    data = json.loads(request.body)
    users = []
    for row in db.execute("SELECT * FROM users"):
        user = {}
        user['id'] = row[0]
        user['name'] = row[1]
        user['email'] = row[2]
        if data.get('include_posts'):
            posts = db.execute(f"SELECT * FROM posts WHERE user_id = {row[0]}")
            user['posts'] = [{'id': p[0], 'title': p[1]} for p in posts]
        users.append(user)
    return JsonResponse({'users': users})
```

## Roast output (gentle)

````
    ┌──────────────┐
    │   ●  ‿  ●    │
    │     ═══      │
    │   ┌─────┐    │
    │   │ TUX │    │
    │   └─────┘    │
    └──────────────┘
  *reads patch, sighs mildly*
````

Look, this works. I can see that it works. But "works" is a very low bar, and I have to say, I'm not impressed.

1. **The N+1 query problem.** You're fetching all users, then for each user, firing a separate query to get their posts. If you have 1,000 users, that's 1,001 database calls. This is a textbook problem with a textbook solution — it's called a JOIN, it's been around since 1970, and it exists specifically so you don't do this. Your database is doing laps around the block when it could walk across the room once.

2. **That f-string is an SQL injection.** `f"SELECT * FROM posts WHERE user_id = {row[0]}"` — you're interpolating values directly into a SQL string. Yes, `row[0]` probably comes from your own database, so the risk is lower than raw user input. But this is still a bad habit. Use parameterized queries. It costs you nothing and it means you won't accidentally teach yourself that string formatting into SQL is acceptable. Because it is not.

3. **`SELECT *` and positional indexing.** You're selecting everything and then accessing columns by number — `row[0]`, `row[1]`, `row[2]`. If someone adds a column to the users table, or reorders them, your code silently returns the wrong data. Name your columns. Use a dictionary cursor. This is fragile in a way that will only bite you at 2 AM on a Saturday.

4. **No pagination, no limits.** This endpoint returns every user in your database in a single response. That's fine when you have 10 users. When you have 100,000, this endpoint becomes a denial-of-service attack against yourself. Add a LIMIT. Accept page parameters. This is not optional for production code.

5. **No error handling.** What happens when `json.loads(request.body)` fails because the request has no body? What happens on a GET request? What happens when the database is unreachable? Right now the answer to all of those is "an unhandled exception and a 500 error." Catch your exceptions. Return meaningful error responses.

This isn't terrible code. It's the kind of code you write when you're learning and nobody has reviewed your work yet. But these are all well-understood problems with well-understood solutions. Read up on them. Fix this. Then resubmit.
