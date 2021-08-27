---
title: Switching SSGs
date: 2020-08-18
---

### Motivation

I originally built this blog with Jekyll, mostly because it was popular and relatively straightforward, and I saw it had something to do with GitHub Pages where I wanted to host this site.

Eventually, as with all things, the bikeshedding started, and I began searching for reasons to move off it. There are some ergonomic factors I consider when evaluating the tech I'm using, and here are a few issues with Jekyll I came up with at the time:

1.  Jekyll isn't very transparent about what it's actually doing at any given time.
2.  It wasn't clear how to change compilation logic if I wanted to.
3.  Automatic syntax highlighting wasn't working consistently between Github Pages and my local environment, and at the time I didn't want to write any CSS.
4.  I don't find Ruby to be as expressive or concise as I'd like a language I'm frequently writing in to be.

Most of these are "me-problems". I didn't want to read the docs to figure out how to fix these things. I had already made up my mind to move to something else.

### Alternatives

I've looked at a few alternatives to Jekyll:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Static Generator</th>
<th scope="col" class="org-left">&#xa0;</th>
<th scope="col" class="org-left">Configuration Language</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">Hugo</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Go</td>
</tr>


<tr>
<td class="org-left">Cobalt</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Rust</td>
</tr>


<tr>
<td class="org-left">Octopress</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">HTML</td>
</tr>


<tr>
<td class="org-left">Hakyll</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Haskell</td>
</tr>


<tr>
<td class="org-left">Styx</td>
<td class="org-left">&#xa0;</td>
<td class="org-left">Nix</td>
</tr>
</tbody>
</table>

Ultimately the 4th reason won; I can write Ruby or whatever else if I have to, but absent other reasons, I don't *like* to. Haskell is much more comfortable for me to work and think in.

*(I also [really like Nix](./nixos.html), and still plan to give Styx a shot, but wasn't able to get it running by the time I first wrote this, and haven't tried since.)*


### Requirements

I'm pretty minimalist as far as design things go, and rather like the default Hakyll layout. I decided to stick with that for a while and try to get the features I wanted working:

1. Syntax highlighting. This one is a must-have, and it wasn't working correctly before.
2. External code inclusion, so I can link in files to make code snippets rather than copy and paste things.
3. LaTeX support.

### Problems Solved

The first thing to do was make sure I could include code snippets in posts and have them lexed and colored correctly. For some reason, I had a lot of trouble making this work with Jekyll + Rouge, so I was eager to see what could be done with Hakyll.

It turned out to be tremendously easy! I followed this [excellent explanation](http://blog.tpleyer.de/posts/2019-04-21-external-code-inclusion-with-hakyll.html) and included all the functions there into my `site.hs`. This also took care of the second problem, of including code from other files.

Unfortunately, `skylighting` (the syntax highlighting library used by Pandoc) doesn't have support for the nix expression language yet. This led to some weirdness in the [last post](./nixos.md) which is still unresolved.

LaTeX support was added by importing the MathJax, and later KaTeX scripts, but this is also unsatisfying. I don't want to force people to run JS when they visit my site, and the extra request and rendering time does slow things down a bit.

### A Departure
I currently live in a place where requests to many popular sites are subject to various forms of filtering and thus don't always work as intended. Two of the missing pieces are githubusercontent and some requests to S3, which make working with open source software quite challenging.

I had to give up Hakyll (and Haskell generally) for a while because Stackage and Hackage were inaccessible. Looking for alternatives, and being an Emacs junkie, I found [org-static-blog](https://github.com/bastibe/org-static-blog), which worked extremely well but ended up being too limiting. Now I'm back on Hakyll, but I do miss native support for reading org-mode files, which [doesn't work in Hakyll yet](https://github.com/jaspervdj/hakyll/issues/700).

### Future Work
The syntax highlighting done by Pandoc isn't exactly what I want. What I'd really like is for the generated CSS to exactly match what I see in Emacs, so when I get some time, I'd like to see about using [Hakyll's shell support](https://hackage.haskell.org/package/hakyll-3.1.2.2/docs/Hakyll-Core-UnixFilter.html) to invoke Emacs, which could then crop and `htmlize` the buffer and save the result, so Hakyll could directly import that. It'd be a decent amount of work.
