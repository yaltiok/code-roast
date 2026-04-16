# API Abominations 🌐

## Abomination #1: GET request that mutates data

**The crime:**
```javascript
app.get('/api/users/:id/delete', (req, res) => {
  db.users.delete(req.params.id);
  res.send('User deleted');
});
```

### Gordon Ramsay — CRITICAL
A GET request that DELETES users?! Are you having a laugh?! This isn't an API, it's a LANDMINE! Every web crawler, every prefetch, every browser that sneezes in the wrong direction is going to nuke your user table! I've seen cleaner decisions at a petrol station buffet!

GET is IDEMPOTENT, you donut! It means "I'm just looking"! You've turned "just looking" into "blow up the database"! Some poor sod's antivirus is going to preview the link and WIPE half your customers! This is a liability, a disaster, a one-way ticket to an incident review! Bin it!

### Gentle Grandma — CRITICAL
Oh sweetheart, I think something went a little sideways here. You see, when browsers see a GET request, they assume it's safe — like peeking at a recipe card. They'll sometimes fetch it ahead of time to be helpful. But your recipe card... deletes the cake, dear.

I remember when the neighbour's Google Bot visited a site just like this and tidied up every single record overnight. The poor developer cried into his tea. Let's use DELETE for deleting, hmm? It's a small change, but it'll save you from a very long Monday morning.

---

## Abomination #2: Every endpoint returns 200, errors in body

**The crime:**
```json
HTTP/1.1 200 OK
{ "success": false, "error": "User not found" }
```

### Linus Torvalds — HIGH
You have HTTP status codes. An entire beautifully specified range of them. 4xx for client errors. 5xx for server errors. And you looked at this rich vocabulary and said "nah, everything is 200, I'll put the truth in a JSON field." This is the API equivalent of labeling every pill bottle "medicine."

Every piece of middleware, every monitoring tool, every retry library on Earth is now useless. Your load balancer thinks you're healthy while you're hemorrhaging 500s. Your Datadog dashboard is a perfect flat green line lying to you. Fix the protocol compliance, or stop calling it HTTP.

### Shakespeare — HIGH
Lo, what false herald doth announce "200 OK" whilst bearing tidings of ruin in its purse? Thy server doth smile whilst the message weeps — a two-faced courier, sworn to truth but whispering lies beneath its cloak of success.

The gods of HTTP did grant thee codes most varied — four hundred for the client's folly, five hundred for thine own — yet thou dost spurn this bounty and cram all sorrow into thy body's prose. Away with this deceit! Let the status speak the heart, lest every client be betrayed by thy cheerful mask.

---

## Abomination #3: Different error shapes per endpoint

**The crime:**
```json
// /api/users       → { "error": "not found" }
// /api/orders      → { "err_msg": "missing", "code": 4 }
// /api/products    → { "errors": [{"detail": "..."}] }
// /api/payments    → "Error: bad request"
```

### Gordon Ramsay — HIGH
FOUR endpoints, FOUR completely different error shapes! It's like every cook in my kitchen decided to plate the same dish on a different set of crockery! One's a JSON object, one's an array, one's a bloody STRING! The frontend developer has to write a switch statement just to figure out what went wrong!

This isn't an API, it's an archaeological dig! Every error is a new mystery! Pick ONE shape. Document it. Enforce it. RFC 7807 exists! Problem Details! Use it! Right now your consumers are writing try-catch hellscapes because you couldn't be bothered to be consistent!

### Shakespeare — MEDIUM
Four messengers ride forth from thy gates, each in strange livery, each speaking in a different tongue. One cries "error!" in plain speech, another mumbles of codes and numbers, a third bears scrolls of arrays, and the fourth, poor soul, speaks only in naked string without vessel to hold him.

How shall the merchant know thy language when thou changest it with every stall? A kingdom is known by the uniformity of its seals. Stamp thy errors with one crest — one shape, one schema — that thy subjects may read thy sorrows without a translator at each gate.

---

## Abomination #4: Three endpoints doing the same thing

**The crime:**
```
GET /api/getUser/:id
GET /api/fetchUser/:id
GET /api/retrieveUser/:id
```

### Linus Torvalds — MEDIUM
Congratulations, you have invented the thesaurus-driven API. Three endpoints, zero decisions. Every new developer joining your team now has to guess which one is the canonical one, which one is deprecated, and which one was added by that intern in 2019 who never cleaned up.

REST has a verb baked into the method. It's called GET. You don't need to also say "get" in the path. `/api/users/:id` is the entire contract. Pick one, redirect the other two, and start apologizing to whoever has to maintain this.

### Gentle Grandma — MEDIUM
Oh honey, I see you've made three little doors that all open into the same living room. That's very generous, but it's going to confuse your guests terribly. Some will use the front door, some will wander around to the side, and nobody will know which one is "right."

When I had three ways to make my pie crust, my daughter finally said "Mom, just pick one and write it down." So let's do that, dear. Pick `/api/users/:id` — it's the nicest of the three — and gently retire the others with a kind little redirect. Your future self will send you flowers.

---

## Abomination #5: Action in URL as GET

**The crime:**
```
GET /api/user/delete/:id
GET /api/order/cancel/:id
GET /api/payment/refund/:id
```

### Gordon Ramsay — CRITICAL
Delete. Cancel. Refund. As GET requests. You've built a WEAPON! Any bored child with a browser extension can walk through your URLs and liquidate your entire business! The back button is now a DESTRUCTIVE action! Browser history is a HIT LIST!

And you put the VERB in the path?! That's what the HTTP METHOD IS FOR, you absolute muppet! DELETE /api/users/:id! POST /api/orders/:id/cancel! It's been a standard since before you were born! Your API is a REST violation AND a security vulnerability — a rare double feature of awful!

### Linus Torvalds — CRITICAL
You've managed to combine two separate disasters into one URL. First, you put a verb in the path even though HTTP already provides verbs — that's just bad taste. Second, you made destructive operations available over GET, which means every single crawler, link preview, and browser prefetch is now a loaded gun pointed at your data.

Slack's link unfurler will refund transactions. Google will cancel orders while indexing. The "warm up the cache" cron job becomes a mass deletion event. This isn't a design choice, this is negligence with a URL scheme.

---

## Abomination #6: Auth token as query param

**The crime:**
```
GET /api/account?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Linus Torvalds — CRITICAL
The token is in the URL. Which means it's in the server access logs. And the proxy logs. And the CDN logs. And the browser history. And the Referer header sent to every third-party image on the page. And probably in someone's screenshot on Slack by now.

Headers exist. `Authorization: Bearer <token>` exists. It has existed for a decade. You chose to take a credential and spray it across every logging surface in the stack. This is how breaches start — not with a clever attacker, but with a grep through nginx logs.

### Gordon Ramsay — HIGH
You've put the KEYS TO THE KINGDOM in the URL! The URL! The thing that gets logged EVERYWHERE! Nginx has it, Cloudflare has it, the user's BROWSER HISTORY has it, and every ad tracker on the referring page just got a FREE LOGIN!

Authorization header. AUTHORIZATION. HEADER. Five syllables. Headers don't leak into Referer. Headers don't get bookmarked. Headers don't show up in a screenshot tweeted at 2am! Move it, rotate every token that's ever touched this endpoint, and go sit in the naughty corner!

---

## Abomination #7: No pagination — returns all 100k rows

**The crime:**
```javascript
app.get('/api/users', async (req, res) => {
  const allUsers = await db.users.findAll(); // returns 100,000 records
  res.json(allUsers);
});
```

### Gordon Ramsay — HIGH
ONE HUNDRED THOUSAND ROWS! In a single response! What are they supposed to do with that?! Scroll for a week?! You've turned a simple list endpoint into a DENIAL OF SERVICE attack on your own users! The browser's crying! Mobile clients are spontaneously combusting!

LIMIT! OFFSET! Cursor pagination! Any of these, I don't care, just PICK ONE! The database is sweating, the network is choking, and some poor phone is trying to render a 40MB JSON blob over 3G! This isn't an API, it's a punishment!

### Gentle Grandma — HIGH
Oh dearie, you've baked one hundred thousand cookies and tried to hand them all over at once. Of course the poor dear dropped the tray! Nobody can carry that many cookies, sweetheart — not even a strong young person with both hands free.

Let's give them cookies a few dozen at a time. You could use a `?page=` parameter, or a little `cursor` to mark where they left off. Then next time they ask, you hand them the next batch. Everyone stays happy, nobody's arms fall off, and your database gets to sit down for a cup of tea between rounds.

---

## Abomination #8: Nested response 8 levels deep

**The crime:**
```json
{
  "data": {
    "result": {
      "response": {
        "payload": {
          "content": {
            "items": {
              "data": {
                "list": [...]
              }
            }
          }
        }
      }
    }
  }
}
```

### Shakespeare — HIGH
What Russian doll of a response is this, wherein each key doth birth another key, which in turn doth spawn yet another, until the weary client, lost in nested realms, forgets what he did seek? `data.result.response.payload.content.items.data.list` — a pilgrimage, not a path!

Each wrapper claims purpose but delivers naught. "Data" holds "result" holds "response" holds "payload" — synonyms stacked like turtles to the bottom of the sea! Flatten thy response, good sir. One envelope, one body, one list. Thy consumers weep with each dot they must traverse.

### Gordon Ramsay — MEDIUM
EIGHT! LEVELS! DEEP! I went to get the list and came back with a beard! `response.data.data.data` — did you get paid by the keystroke?! Every one of those wrappers is a synonym for the one above it! Data! Result! Payload! Content! PICK ONE!

The frontend now has to write `response?.data?.result?.response?.payload?.content?.items?.data?.list` just to see a bloody array! One wrong null and the whole thing explodes! Flatten it! `{ users: [...], page: 1, total: 100 }` — DONE! Two levels, maximum! Stop building JSON matryoshkas!

---

## Abomination #9: Breaking changes without versioning

**The crime:**
```
// Yesterday:
GET /api/users → [{ "id": 1, "name": "Alice" }]

// Today, same URL:
GET /api/users → [{ "user_id": 1, "full_name": "Alice", "shape_changed": true }]
```

### Linus Torvalds — CRITICAL
You renamed `id` to `user_id` on a live endpoint. No version bump. No deprecation header. No email. Somewhere out there, a mobile app from six months ago that hasn't been updated is now silently failing for every user who opens it. You broke a contract in production without telling anyone.

There is a reason `/v1/`, `/v2/` exists. There is a reason `Accept: application/vnd.example.v2+json` exists. You had options. You chose the one that makes every stale client on Earth crash on a Tuesday. Own it, revert it, and learn what "versioning" means before touching another public endpoint.

### Shakespeare — CRITICAL
Thou hast changed the very words of thy covenant whilst thy subjects sleep! Yestereve they knew thee by "id" and "name" — this dawn thou dost speak "user_id" and "full_name," as though thy tongue were new-forged in the night. Is this a herald's honor, to rewrite the scroll mid-reading?

Every faithful client, trusting in yesterday's oath, doth now break upon the rocks of thy caprice. Version thy contracts, noble fool! `/v1` and `/v2` are not mere ornament — they are the promise that what was once spoken shall remain true, until thou dost ring the bell of change.

---

## Abomination #10: Status codes used wrong

**The crime:**
```
POST /api/users { email: "not-an-email" }
→ 500 Internal Server Error

GET /api/users/999999
→ 200 OK { "error": true, "message": "Not found" }
```

### Linus Torvalds — HIGH
Validation error returns 500. "Not found" returns 200. You have inverted the entire semantic meaning of HTTP. A 500 means "the server is broken." A user typing a bad email is not the server breaking — that's a 400. A missing resource is 404, not "200 with a sad JSON."

Monitoring is now lying to you in both directions. Your alerting fires for user typos. Your uptime graph is green while half your lookups fail silently. Every caching layer, every CDN, every client library is making wrong decisions because you used the wrong number. Status codes aren't decorative — they're a protocol.

### Gordon Ramsay — HIGH
A BAD EMAIL triggers a FIVE HUNDRED?! That tells the entire internet your SERVER is on fire when actually it's just Gary who typed "jim@@gmail"! PagerDuty is calling the on-call engineer at 3am because of a TYPO! You've weaponized your own monitoring against yourself!

And 200 OK for NOT FOUND?! With `error: true` hidden in the body like a raisin in a cookie?! 404 EXISTS! 400 EXISTS! They're free! They're standard! Every CDN, every proxy, every tool on Earth reads status codes and you're LYING TO ALL OF THEM! Sort it!

---

## Abomination #11: POST body for GET operations

**The crime:**
```http
POST /api/search HTTP/1.1
Content-Type: application/json

{ "query": "laptops", "filters": {...} }
```
> Developer comment: "Query strings are too short for our filters"

### Gordon Ramsay — MEDIUM
"Query strings are too short!" Oh, is that what the RFC says, is it?! Query strings can be THOUSANDS of characters! You didn't hit the limit, you just couldn't be bothered to URL-encode a JSON object! So now SEARCH — the most cacheable, bookmarkable, shareable operation in existence — is a POST!

Nothing caches it. Nothing bookmarks it. Users can't share search results. The CDN throws up its hands. All because you thought "POST is easier." It's not easier — it's LAZY! Either use query params properly or use a proper SEARCH spec. But don't POST your GETs like a savage!

### Shakespeare — LOW
"The query string is too narrow!" thou dost cry, as though the margins of a scroll could not be widened. Two thousand characters and more doth URL allow thee, yet thou dost flee into the warm belly of POST, where no cache may find thee nor bookmark hold thee fast.

A search, by its nature, is a question asked — not a deed done. It should be idempotent, cacheable, shareable as a merry sonnet passed among friends. Thou hast locked thy search behind a door marked "mutation," and now no proxy, no CDN, no bookmark may grant thy users swift return.

---

## Abomination #12: Five endpoints in specific order for one task

**The crime:**
```
// To place an order, client MUST call in order:
// 1. POST /api/cart/init
// 2. POST /api/cart/attach-user
// 3. POST /api/cart/add-items
// 4. POST /api/cart/calculate-totals
// 5. POST /api/cart/finalize
// Skip a step? Undefined behavior. Out of order? 500 error.
```

### Linus Torvalds — HIGH
You took one logical operation — "place an order" — and shattered it into five stateful calls that must happen in a sacred sequence. The server now holds partial state between every call. If the client drops in the middle, you have zombie carts. If the order is wrong, you 500. If two calls race, you corrupt state.

This is a transaction pretending to be an API. Either make it one `POST /api/orders` with the full payload and let the server orchestrate atomically, or build a proper state machine with explicit resource URLs. What you have is a fragile RPC chain that leaks memory and breaks on every network hiccup.

### Gentle Grandma — HIGH
Oh my goodness, dear, you've made placing an order feel like one of those escape rooms! Five little steps, and heaven help you if you do them in the wrong order — the whole thing locks up! When I order groceries, I don't want to call the shop five times. I want to say "here's my list" and they handle the rest.

Poor network connections drop, sweetheart. A customer halfway through step three loses signal, and now there's a lonely little half-cart sitting in your database forever. Let's bundle it into one tidy request, hmm? The server can do the shuffling inside. Your customers will thank you, and your database won't fill up with orphaned carts like socks in a dryer.

---

## Abomination #13: Response contains internal IDs, stack traces, SQL queries

**The crime:**
```json
{
  "error": "DB error",
  "query": "SELECT * FROM users WHERE email='admin@co.com' AND password_hash='$2b$...'",
  "stack": "at UserRepo.findByEmail (/app/src/internal/repos/user.js:42)\n  at AuthService...",
  "internal_user_id": "usr_internal_8839201",
  "db_host": "prod-primary-us-east-1.rds.amazonaws.com"
}
```

### Linus Torvalds — CRITICAL
This response is a penetration test's opening gift. You leaked the SQL statement, the bcrypt hash schema location, the file path of your auth service, the internal ID format, and the production database hostname — all in one error body. An attacker doesn't need to probe you, they just need to trigger errors and read the map you handed them.

Error responses should contain a stable error code, a user-safe message, and a correlation ID for your logs. That's it. Stack traces, queries, internal identifiers, and infrastructure hostnames belong in your server logs, not on the wire. Rotate the hash you just exposed, audit every endpoint for the same leak, and ship a generic error envelope before someone less polite than me finds it.

### Gordon Ramsay — CRITICAL
YOU'VE HANDED THEM THE RECIPE, THE KITCHEN LAYOUT, AND THE SAFE COMBINATION! SQL query with a PASSWORD HASH in it?! Stack traces pointing to your file structure?! The DATABASE HOSTNAME?! Might as well have printed "HACK ME" on a billboard with an arrow!

Every error response is a love letter to an attacker! Internal user IDs — now they can enumerate! File paths — now they know your stack! RDS hostname — now they're probing it directly! Wipe this endpoint, rotate EVERYTHING, and give the users a nice boring `{ "error": "Something went wrong", "trace_id": "abc123" }`! Keep the gory details on the SERVER where they belong!

---
