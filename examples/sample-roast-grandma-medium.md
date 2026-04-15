# Example: Gentle Grandma roasts a Promise chain nightmare

## Input code

```javascript
function getData() {
  return fetch('/api/users')
    .then(res => {
      return res.json().then(users => {
        return fetch('/api/posts').then(res2 => {
          return res2.json().then(posts => {
            return fetch('/api/comments').then(res3 => {
              return res3.json().then(comments => {
                return { users, posts, comments };
              })
            })
          })
        })
      })
    })
    .catch(err => console.log(err))
}
```

## Roast output (medium)

````
    ┌──────────────┐
    │   ◉   ◉     │
    │    ╰▄╯       │
    │   ╭┈┈┈┈╮    │
    │   ┆ 📞 ┆    │
    │   ╰┈┈┈┈╯    │
    └──────────────┘
  *squints, tilts screen*
````

Honey... come here a moment. Sit. No, bring a chair, this might take a while.

I'm looking at your code and I'm tilting my laptop and I'm tilting my HEAD and I still can't tell where one `.then` ends and the next begins. Let me get my reading glasses. The OTHER reading glasses. The ones for EMERGENCIES.

1. **Sweetheart, how deep does this go?** I counted the indentation levels. SIX. Six levels deep! When I was at IBM, we had a rule: if your code nests deeper than your filing cabinet has drawers, you need to RETHINK. My filing cabinet had four drawers, and it held records for the ENTIRE east coast branch office. Your function fetches three things from the internet and somehow needs MORE NESTING than my filing cabinet. This is not a compliment.

2. **You know about `async/await`, yes?** They invented it for exactly this situation. Instead of `.then` inside `.then` inside `.then` like those Russian nesting dolls your uncle brought from his trip — you just write `const users = await fetch('/api/users').then(r => r.json())`. Flat. Clean. Your grandmother can read it without getting vertigo. Here, let me show you what this COULD look like:

   ```javascript
   async function getData() {
     const users = await fetch('/api/users').then(r => r.json());
     const posts = await fetch('/api/posts').then(r => r.json());
     const comments = await fetch('/api/comments').then(r => r.json());
     return { users, posts, comments };
   }
   ```

   Look at that! Flat as a pancake! And if you want them all to run at the SAME TIME — because none of them depend on each other, I notice! — you use `Promise.all`. Your cousin Kevin taught me this. I'm not comparing, I'm just saying he taught me.

3. **That `.catch(err => console.log(err))`.** Oh, honey. Your error handling is `console.log`. You catch the error, you WHISPER it into the console where nobody will ever see it, and then you return `undefined` to whoever called this function. They asked for users, posts, and comments. They got `undefined`. And they will have NO IDEA why. This is like when the doctor calls and says "your results came back" and hangs up. WHAT results?! Am I okay?! You need to TELL PEOPLE what went wrong!

4. **The three fetches don't depend on each other.** You're fetching users, THEN posts, THEN comments — one after another, sequentially, waiting for each to finish. But posts don't need users! Comments don't need posts! You're making them wait in line like at the post office when there are THREE open windows. Use `Promise.all` and let them all go at once. Your page will load three times faster. Your users will THANK you.

I'm not angry, dear. This code WORKS. It fetches the data and it returns the data. But it's wrapped in so many layers that I'm getting sympathy claustrophobia.

Flatten it out. Handle your errors properly. Let independent things run in parallel. And call your grandmother more often — I worry.
