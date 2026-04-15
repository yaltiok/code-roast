# Example: Gordon Ramsay gently roasts a React component

## Input code

```tsx
function UserProfile({ user }) {
  const [loading, setLoading] = useState(true);
  const [posts, setPosts] = useState([]);
  const [error, setError] = useState(null);
  const [comments, setComments] = useState([]);
  const [followers, setFollowers] = useState([]);
  const [following, setFollowing] = useState([]);
  
  useEffect(() => {
    fetch(`/api/users/${user.id}/posts`).then(r => r.json()).then(setPosts);
    fetch(`/api/users/${user.id}/comments`).then(r => r.json()).then(setComments);
    fetch(`/api/users/${user.id}/followers`).then(r => r.json()).then(setFollowers);
    fetch(`/api/users/${user.id}/following`).then(r => r.json()).then(setFollowing);
    setLoading(false);
  }, []);

  if (loading) return <div>Loading...</div>;
  
  return (
    <div>
      <h1>{user.name}</h1>
      <p>{posts.length} posts, {followers.length} followers</p>
    </div>
  );
}
```

## Roast output (gentle)

````
    ╭─────────────╮
    │  ⚆ _ ⚆     │
    │    ╰─╯      │
    │  ┌─────┐    │
    │  │CHEF │    │
    │  └─────┘    │
    ╰─────────────╯
  "Look... it's not terrible."
````

Right. Come here. Sit down. No, I'm not going to yell. I can see you're TRYING, and that counts for something. But we need to talk about this component, because it's got the bones of a decent dish with some very questionable seasoning.

1. **The race condition, darling.** You're firing off four `fetch` calls, and then IMMEDIATELY calling `setLoading(false)` on the very next line. Those fetches are asynchronous! They haven't finished yet! You're telling the user "all done loading!" while the kitchen is still cooking! That loading spinner disappears before a single byte of data has arrived. Your users are staring at a "0 posts, 0 followers" screen wondering if they're that unpopular. Use `Promise.all`, wait for everything to resolve, THEN set loading to false.

2. **No error handling on ANY of those fetches.** Four network requests, zero `.catch()` blocks. What happens when one of those endpoints is down? I'll tell you what happens — NOTHING. The promise rejects silently into the void. No error message, no fallback, no indication that anything went wrong. You've got an `error` state variable sitting RIGHT THERE, completely unused, like a fire extinguisher still in the packaging. HOOK IT UP.

3. **That dependency array.** `useEffect(() => { ... }, [])` — you're depending on `user.id` inside the effect but it's not in the dependency array. If the user prop changes, your effect won't re-run, and now you're showing stale data for the wrong person. ESLint is screaming about this, by the way. Listen to it. It's smarter than both of us on dependency arrays.

4. **Two state variables you never use.** `comments` and `following` — you fetch them, you store them, and then what? They sit there, taking up memory, doing absolutely nothing. It's like buying ingredients, washing them, prepping them, and then throwing them in the bin. If the render doesn't need them, don't fetch them. And if you're planning to use them later, fine, but finish the dish before you plate it.

Look. The structure is there. You've got your state, your effect, your conditional render. It's not a disaster — it's an ALMOST. Fix the race condition, handle your errors, clean up what you don't need, and this could actually be a respectable component. Now get back in there.
